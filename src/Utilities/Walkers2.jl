"""
Provides the [`walk`](@ref) function for walking over a [`Markdown2.MD`](@ref) tree.
"""
module Walkers2

import ..Utilities: Markdown2

using Compat, DocStringExtensions

"""
$(SIGNATURES)

Calls `f(element)` on `element` and any of its child elements.
"""
function walk end

function walk(f, node::T) where {T <: Union{Markdown2.MarkdownNode, Markdown2.MD}}
    f(node) || return
    if :nodes in fieldnames(T)
        walk(f, node.nodes)
    end
    return
end

function walk(f, nodes::Vector)
    for node in nodes
        walk(f, node)
    end
end

function walk(f, list::Markdown2.List)
    f(list) || return
    for item in list.items
        walk(f, item)
    end
end

function walk(f, table::Markdown2.Table)
    f(table) || return
    for cell in table.cells
        walk(f, cell)
    end
end

end
