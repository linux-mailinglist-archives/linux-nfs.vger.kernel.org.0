Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C2497D2F
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 11:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiAXK3l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 05:29:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:64494 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237135AbiAXK3k (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 24 Jan 2022 05:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643020180; x=1674556180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZKGgdSwgXFoE92bnX/C+rn4r+sKCzSR3+q0OvQ/x8M=;
  b=OdURzQ9bI7HGGOAxkEPpyK8cun8eR8Fpu7cDJVaTeRltfPmaGRfYHZjS
   kmvJGYI3gd3ksMZr7Y5YtPILmDDG92b1P+1OMjh5SypA6MtS0NsyKrZNA
   WM40Udt8pBiBLX5xmIdCIO2fKZuYscl9i3Wok9wqxK/nSkI/gMPybrZAB
   bpkydrNM6kRAxzprh90FQNNuxzpXZDrpFQrh7A5dJwXjL92ZTRWEKIHin
   Xabfec56WAH7Xe3noHV9E0FEt7QNlkctX4GaPA0LVlD0i1o+CVVEs0uzB
   TDjEFqmRfEARhvDb/Pi0IydFkUJMf30pHM6Slk/mVaAbA7TGJy99H+onA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="225995552"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="225995552"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695377920"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 02:29:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBwbP-000IBs-QU; Mon, 24 Jan 2022 10:29:35 +0000
Date:   Mon, 24 Jan 2022 18:29:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/23] MM: submit multipage write for SWP_FS_OPS
 swap-space
Message-ID: <202201241811.2ofGi6Q2-lkp@intel.com>
References: <164299611279.26253.12350012848236496937.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611279.26253.12350012848236496937.stgit@noble.brown>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NeilBrown,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc1 next-20220124]
[cannot apply to trondmy-nfs/linux-next cifs/for-next hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/NeilBrown/Repair-SWAP-over_NFS/20220124-115716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220124/202201241811.2ofGi6Q2-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/267352b9af826e20ab71b46a7cd70d51058b3030
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review NeilBrown/Repair-SWAP-over_NFS/20220124-115716
        git checkout 267352b9af826e20ab71b46a7cd70d51058b3030
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/vmscan.c:61:
   mm/swap.h:68:1: error: expected identifier or '(' before '{' token
      68 | {
         | ^
   mm/vmscan.c: In function 'shrink_page_list':
>> mm/vmscan.c:1978:17: error: implicit declaration of function 'swap_write_unplug'; did you mean 'swap_writepage'? [-Werror=implicit-function-declaration]
    1978 |                 swap_write_unplug(plug);
         |                 ^~~~~~~~~~~~~~~~~
         |                 swap_writepage
   In file included from mm/vmscan.c:61:
   mm/vmscan.c: At top level:
   mm/swap.h:66:19: warning: 'swap_readpage' declared 'static' but never defined [-Wunused-function]
      66 | static inline int swap_readpage(struct page *page, bool do_poll,
         |                   ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1978 mm/vmscan.c

  1526	
  1527	/*
  1528	 * shrink_page_list() returns the number of reclaimed pages
  1529	 */
  1530	static unsigned int shrink_page_list(struct list_head *page_list,
  1531					     struct pglist_data *pgdat,
  1532					     struct scan_control *sc,
  1533					     struct reclaim_stat *stat,
  1534					     bool ignore_references)
  1535	{
  1536		LIST_HEAD(ret_pages);
  1537		LIST_HEAD(free_pages);
  1538		LIST_HEAD(demote_pages);
  1539		unsigned int nr_reclaimed = 0;
  1540		unsigned int pgactivate = 0;
  1541		bool do_demote_pass;
  1542		struct swap_iocb *plug = NULL;
  1543	
  1544		memset(stat, 0, sizeof(*stat));
  1545		cond_resched();
  1546		do_demote_pass = can_demote(pgdat->node_id, sc);
  1547	
  1548	retry:
  1549		while (!list_empty(page_list)) {
  1550			struct address_space *mapping;
  1551			struct page *page;
  1552			enum page_references references = PAGEREF_RECLAIM;
  1553			bool dirty, writeback;
  1554			unsigned int nr_pages;
  1555	
  1556			cond_resched();
  1557	
  1558			page = lru_to_page(page_list);
  1559			list_del(&page->lru);
  1560	
  1561			if (!trylock_page(page))
  1562				goto keep;
  1563	
  1564			VM_BUG_ON_PAGE(PageActive(page), page);
  1565	
  1566			nr_pages = compound_nr(page);
  1567	
  1568			/* Account the number of base pages even though THP */
  1569			sc->nr_scanned += nr_pages;
  1570	
  1571			if (unlikely(!page_evictable(page)))
  1572				goto activate_locked;
  1573	
  1574			if (!sc->may_unmap && page_mapped(page))
  1575				goto keep_locked;
  1576	
  1577			/*
  1578			 * The number of dirty pages determines if a node is marked
  1579			 * reclaim_congested. kswapd will stall and start writing
  1580			 * pages if the tail of the LRU is all dirty unqueued pages.
  1581			 */
  1582			page_check_dirty_writeback(page, &dirty, &writeback);
  1583			if (dirty || writeback)
  1584				stat->nr_dirty++;
  1585	
  1586			if (dirty && !writeback)
  1587				stat->nr_unqueued_dirty++;
  1588	
  1589			/*
  1590			 * Treat this page as congested if the underlying BDI is or if
  1591			 * pages are cycling through the LRU so quickly that the
  1592			 * pages marked for immediate reclaim are making it to the
  1593			 * end of the LRU a second time.
  1594			 */
  1595			mapping = page_mapping(page);
  1596			if (((dirty || writeback) && mapping &&
  1597			     inode_write_congested(mapping->host)) ||
  1598			    (writeback && PageReclaim(page)))
  1599				stat->nr_congested++;
  1600	
  1601			/*
  1602			 * If a page at the tail of the LRU is under writeback, there
  1603			 * are three cases to consider.
  1604			 *
  1605			 * 1) If reclaim is encountering an excessive number of pages
  1606			 *    under writeback and this page is both under writeback and
  1607			 *    PageReclaim then it indicates that pages are being queued
  1608			 *    for IO but are being recycled through the LRU before the
  1609			 *    IO can complete. Waiting on the page itself risks an
  1610			 *    indefinite stall if it is impossible to writeback the
  1611			 *    page due to IO error or disconnected storage so instead
  1612			 *    note that the LRU is being scanned too quickly and the
  1613			 *    caller can stall after page list has been processed.
  1614			 *
  1615			 * 2) Global or new memcg reclaim encounters a page that is
  1616			 *    not marked for immediate reclaim, or the caller does not
  1617			 *    have __GFP_FS (or __GFP_IO if it's simply going to swap,
  1618			 *    not to fs). In this case mark the page for immediate
  1619			 *    reclaim and continue scanning.
  1620			 *
  1621			 *    Require may_enter_fs() because we would wait on fs, which
  1622			 *    may not have submitted IO yet. And the loop driver might
  1623			 *    enter reclaim, and deadlock if it waits on a page for
  1624			 *    which it is needed to do the write (loop masks off
  1625			 *    __GFP_IO|__GFP_FS for this reason); but more thought
  1626			 *    would probably show more reasons.
  1627			 *
  1628			 * 3) Legacy memcg encounters a page that is already marked
  1629			 *    PageReclaim. memcg does not have any dirty pages
  1630			 *    throttling so we could easily OOM just because too many
  1631			 *    pages are in writeback and there is nothing else to
  1632			 *    reclaim. Wait for the writeback to complete.
  1633			 *
  1634			 * In cases 1) and 2) we activate the pages to get them out of
  1635			 * the way while we continue scanning for clean pages on the
  1636			 * inactive list and refilling from the active list. The
  1637			 * observation here is that waiting for disk writes is more
  1638			 * expensive than potentially causing reloads down the line.
  1639			 * Since they're marked for immediate reclaim, they won't put
  1640			 * memory pressure on the cache working set any longer than it
  1641			 * takes to write them to disk.
  1642			 */
  1643			if (PageWriteback(page)) {
  1644				/* Case 1 above */
  1645				if (current_is_kswapd() &&
  1646				    PageReclaim(page) &&
  1647				    test_bit(PGDAT_WRITEBACK, &pgdat->flags)) {
  1648					stat->nr_immediate++;
  1649					goto activate_locked;
  1650	
  1651				/* Case 2 above */
  1652				} else if (writeback_throttling_sane(sc) ||
  1653				    !PageReclaim(page) || !may_enter_fs(page, sc->gfp_mask)) {
  1654					/*
  1655					 * This is slightly racy - end_page_writeback()
  1656					 * might have just cleared PageReclaim, then
  1657					 * setting PageReclaim here end up interpreted
  1658					 * as PageReadahead - but that does not matter
  1659					 * enough to care.  What we do want is for this
  1660					 * page to have PageReclaim set next time memcg
  1661					 * reclaim reaches the tests above, so it will
  1662					 * then wait_on_page_writeback() to avoid OOM;
  1663					 * and it's also appropriate in global reclaim.
  1664					 */
  1665					SetPageReclaim(page);
  1666					stat->nr_writeback++;
  1667					goto activate_locked;
  1668	
  1669				/* Case 3 above */
  1670				} else {
  1671					unlock_page(page);
  1672					wait_on_page_writeback(page);
  1673					/* then go back and try same page again */
  1674					list_add_tail(&page->lru, page_list);
  1675					continue;
  1676				}
  1677			}
  1678	
  1679			if (!ignore_references)
  1680				references = page_check_references(page, sc);
  1681	
  1682			switch (references) {
  1683			case PAGEREF_ACTIVATE:
  1684				goto activate_locked;
  1685			case PAGEREF_KEEP:
  1686				stat->nr_ref_keep += nr_pages;
  1687				goto keep_locked;
  1688			case PAGEREF_RECLAIM:
  1689			case PAGEREF_RECLAIM_CLEAN:
  1690				; /* try to reclaim the page below */
  1691			}
  1692	
  1693			/*
  1694			 * Before reclaiming the page, try to relocate
  1695			 * its contents to another node.
  1696			 */
  1697			if (do_demote_pass &&
  1698			    (thp_migration_supported() || !PageTransHuge(page))) {
  1699				list_add(&page->lru, &demote_pages);
  1700				unlock_page(page);
  1701				continue;
  1702			}
  1703	
  1704			/*
  1705			 * Anonymous process memory has backing store?
  1706			 * Try to allocate it some swap space here.
  1707			 * Lazyfree page could be freed directly
  1708			 */
  1709			if (PageAnon(page) && PageSwapBacked(page)) {
  1710				if (!PageSwapCache(page)) {
  1711					if (!(sc->gfp_mask & __GFP_IO))
  1712						goto keep_locked;
  1713					if (page_maybe_dma_pinned(page))
  1714						goto keep_locked;
  1715					if (PageTransHuge(page)) {
  1716						/* cannot split THP, skip it */
  1717						if (!can_split_huge_page(page, NULL))
  1718							goto activate_locked;
  1719						/*
  1720						 * Split pages without a PMD map right
  1721						 * away. Chances are some or all of the
  1722						 * tail pages can be freed without IO.
  1723						 */
  1724						if (!compound_mapcount(page) &&
  1725						    split_huge_page_to_list(page,
  1726									    page_list))
  1727							goto activate_locked;
  1728					}
  1729					if (!add_to_swap(page)) {
  1730						if (!PageTransHuge(page))
  1731							goto activate_locked_split;
  1732						/* Fallback to swap normal pages */
  1733						if (split_huge_page_to_list(page,
  1734									    page_list))
  1735							goto activate_locked;
  1736	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  1737						count_vm_event(THP_SWPOUT_FALLBACK);
  1738	#endif
  1739						if (!add_to_swap(page))
  1740							goto activate_locked_split;
  1741					}
  1742	
  1743					/* Adding to swap updated mapping */
  1744					mapping = page_mapping(page);
  1745				}
  1746			} else if (unlikely(PageTransHuge(page))) {
  1747				/* Split file THP */
  1748				if (split_huge_page_to_list(page, page_list))
  1749					goto keep_locked;
  1750			}
  1751	
  1752			/*
  1753			 * THP may get split above, need minus tail pages and update
  1754			 * nr_pages to avoid accounting tail pages twice.
  1755			 *
  1756			 * The tail pages that are added into swap cache successfully
  1757			 * reach here.
  1758			 */
  1759			if ((nr_pages > 1) && !PageTransHuge(page)) {
  1760				sc->nr_scanned -= (nr_pages - 1);
  1761				nr_pages = 1;
  1762			}
  1763	
  1764			/*
  1765			 * The page is mapped into the page tables of one or more
  1766			 * processes. Try to unmap it here.
  1767			 */
  1768			if (page_mapped(page)) {
  1769				enum ttu_flags flags = TTU_BATCH_FLUSH;
  1770				bool was_swapbacked = PageSwapBacked(page);
  1771	
  1772				if (unlikely(PageTransHuge(page)))
  1773					flags |= TTU_SPLIT_HUGE_PMD;
  1774	
  1775				try_to_unmap(page, flags);
  1776				if (page_mapped(page)) {
  1777					stat->nr_unmap_fail += nr_pages;
  1778					if (!was_swapbacked && PageSwapBacked(page))
  1779						stat->nr_lazyfree_fail += nr_pages;
  1780					goto activate_locked;
  1781				}
  1782			}
  1783	
  1784			if (PageDirty(page)) {
  1785				/*
  1786				 * Only kswapd can writeback filesystem pages
  1787				 * to avoid risk of stack overflow. But avoid
  1788				 * injecting inefficient single-page IO into
  1789				 * flusher writeback as much as possible: only
  1790				 * write pages when we've encountered many
  1791				 * dirty pages, and when we've already scanned
  1792				 * the rest of the LRU for clean pages and see
  1793				 * the same dirty pages again (PageReclaim).
  1794				 */
  1795				if (page_is_file_lru(page) &&
  1796				    (!current_is_kswapd() || !PageReclaim(page) ||
  1797				     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
  1798					/*
  1799					 * Immediately reclaim when written back.
  1800					 * Similar in principal to deactivate_page()
  1801					 * except we already have the page isolated
  1802					 * and know it's dirty
  1803					 */
  1804					inc_node_page_state(page, NR_VMSCAN_IMMEDIATE);
  1805					SetPageReclaim(page);
  1806	
  1807					goto activate_locked;
  1808				}
  1809	
  1810				if (references == PAGEREF_RECLAIM_CLEAN)
  1811					goto keep_locked;
  1812				if (!may_enter_fs(page, sc->gfp_mask))
  1813					goto keep_locked;
  1814				if (!sc->may_writepage)
  1815					goto keep_locked;
  1816	
  1817				/*
  1818				 * Page is dirty. Flush the TLB if a writable entry
  1819				 * potentially exists to avoid CPU writes after IO
  1820				 * starts and then write it out here.
  1821				 */
  1822				try_to_unmap_flush_dirty();
  1823				switch (pageout(page, mapping, &plug)) {
  1824				case PAGE_KEEP:
  1825					goto keep_locked;
  1826				case PAGE_ACTIVATE:
  1827					goto activate_locked;
  1828				case PAGE_SUCCESS:
  1829					stat->nr_pageout += thp_nr_pages(page);
  1830	
  1831					if (PageWriteback(page))
  1832						goto keep;
  1833					if (PageDirty(page))
  1834						goto keep;
  1835	
  1836					/*
  1837					 * A synchronous write - probably a ramdisk.  Go
  1838					 * ahead and try to reclaim the page.
  1839					 */
  1840					if (!trylock_page(page))
  1841						goto keep;
  1842					if (PageDirty(page) || PageWriteback(page))
  1843						goto keep_locked;
  1844					mapping = page_mapping(page);
  1845					fallthrough;
  1846				case PAGE_CLEAN:
  1847					; /* try to free the page below */
  1848				}
  1849			}
  1850	
  1851			/*
  1852			 * If the page has buffers, try to free the buffer mappings
  1853			 * associated with this page. If we succeed we try to free
  1854			 * the page as well.
  1855			 *
  1856			 * We do this even if the page is PageDirty().
  1857			 * try_to_release_page() does not perform I/O, but it is
  1858			 * possible for a page to have PageDirty set, but it is actually
  1859			 * clean (all its buffers are clean).  This happens if the
  1860			 * buffers were written out directly, with submit_bh(). ext3
  1861			 * will do this, as well as the blockdev mapping.
  1862			 * try_to_release_page() will discover that cleanness and will
  1863			 * drop the buffers and mark the page clean - it can be freed.
  1864			 *
  1865			 * Rarely, pages can have buffers and no ->mapping.  These are
  1866			 * the pages which were not successfully invalidated in
  1867			 * truncate_cleanup_page().  We try to drop those buffers here
  1868			 * and if that worked, and the page is no longer mapped into
  1869			 * process address space (page_count == 1) it can be freed.
  1870			 * Otherwise, leave the page on the LRU so it is swappable.
  1871			 */
  1872			if (page_has_private(page)) {
  1873				if (!try_to_release_page(page, sc->gfp_mask))
  1874					goto activate_locked;
  1875				if (!mapping && page_count(page) == 1) {
  1876					unlock_page(page);
  1877					if (put_page_testzero(page))
  1878						goto free_it;
  1879					else {
  1880						/*
  1881						 * rare race with speculative reference.
  1882						 * the speculative reference will free
  1883						 * this page shortly, so we may
  1884						 * increment nr_reclaimed here (and
  1885						 * leave it off the LRU).
  1886						 */
  1887						nr_reclaimed++;
  1888						continue;
  1889					}
  1890				}
  1891			}
  1892	
  1893			if (PageAnon(page) && !PageSwapBacked(page)) {
  1894				/* follow __remove_mapping for reference */
  1895				if (!page_ref_freeze(page, 1))
  1896					goto keep_locked;
  1897				/*
  1898				 * The page has only one reference left, which is
  1899				 * from the isolation. After the caller puts the
  1900				 * page back on lru and drops the reference, the
  1901				 * page will be freed anyway. It doesn't matter
  1902				 * which lru it goes. So we don't bother checking
  1903				 * PageDirty here.
  1904				 */
  1905				count_vm_event(PGLAZYFREED);
  1906				count_memcg_page_event(page, PGLAZYFREED);
  1907			} else if (!mapping || !__remove_mapping(mapping, page, true,
  1908								 sc->target_mem_cgroup))
  1909				goto keep_locked;
  1910	
  1911			unlock_page(page);
  1912	free_it:
  1913			/*
  1914			 * THP may get swapped out in a whole, need account
  1915			 * all base pages.
  1916			 */
  1917			nr_reclaimed += nr_pages;
  1918	
  1919			/*
  1920			 * Is there need to periodically free_page_list? It would
  1921			 * appear not as the counts should be low
  1922			 */
  1923			if (unlikely(PageTransHuge(page)))
  1924				destroy_compound_page(page);
  1925			else
  1926				list_add(&page->lru, &free_pages);
  1927			continue;
  1928	
  1929	activate_locked_split:
  1930			/*
  1931			 * The tail pages that are failed to add into swap cache
  1932			 * reach here.  Fixup nr_scanned and nr_pages.
  1933			 */
  1934			if (nr_pages > 1) {
  1935				sc->nr_scanned -= (nr_pages - 1);
  1936				nr_pages = 1;
  1937			}
  1938	activate_locked:
  1939			/* Not a candidate for swapping, so reclaim swap space. */
  1940			if (PageSwapCache(page) && (mem_cgroup_swap_full(page) ||
  1941							PageMlocked(page)))
  1942				try_to_free_swap(page);
  1943			VM_BUG_ON_PAGE(PageActive(page), page);
  1944			if (!PageMlocked(page)) {
  1945				int type = page_is_file_lru(page);
  1946				SetPageActive(page);
  1947				stat->nr_activate[type] += nr_pages;
  1948				count_memcg_page_event(page, PGACTIVATE);
  1949			}
  1950	keep_locked:
  1951			unlock_page(page);
  1952	keep:
  1953			list_add(&page->lru, &ret_pages);
  1954			VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
  1955		}
  1956		/* 'page_list' is always empty here */
  1957	
  1958		/* Migrate pages selected for demotion */
  1959		nr_reclaimed += demote_page_list(&demote_pages, pgdat);
  1960		/* Pages that could not be demoted are still in @demote_pages */
  1961		if (!list_empty(&demote_pages)) {
  1962			/* Pages which failed to demoted go back on @page_list for retry: */
  1963			list_splice_init(&demote_pages, page_list);
  1964			do_demote_pass = false;
  1965			goto retry;
  1966		}
  1967	
  1968		pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
  1969	
  1970		mem_cgroup_uncharge_list(&free_pages);
  1971		try_to_unmap_flush();
  1972		free_unref_page_list(&free_pages);
  1973	
  1974		list_splice(&ret_pages, page_list);
  1975		count_vm_events(PGACTIVATE, pgactivate);
  1976	
  1977		if (plug)
> 1978			swap_write_unplug(plug);
  1979		return nr_reclaimed;
  1980	}
  1981	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
