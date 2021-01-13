Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E812F4D6E
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 15:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbhAMOnx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 09:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbhAMOnx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jan 2021 09:43:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABBC061575
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jan 2021 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QNQINrc3aJBiPkPR6UycPtLSU1crJ5VdH0uN0ZQMfrw=; b=nLab75VE97AGOnf+SQxAzU2e2i
        9ZIqox38UiMXnonNSwP7QoDmIF9h4gyfIR89CwNzCfB3Iovz+oCCcjmZUeCgHbeaiRF2W0i0OMu3r
        sNPgFcqGxIt1sh/8yD1bQjqlFB5kGIP89vuIiSDRtl0e3SO0201bI37XgDOWjS8yfyzduYjxITnl6
        OKaJNWF4oeA/3DV5idGc4C0Nm0Unf4LtvVpdqixG2AaHq1j3xaaCqozkcwJLGnZbqPQhThsjDyqWR
        BtuAGIgG/xTER26ZOslE1FmVoKalCvC4rQTIOsqoKb/nJd16wFRK54d2gY0KZPg7EAG4SVQyCQ/rK
        4TJIOGqQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzhJy-006N2k-5f; Wed, 13 Jan 2021 14:40:35 +0000
Date:   Wed, 13 Jan 2021 14:40:26 +0000
From:   "hch@infradead.org" <hch@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "pgoetz@math.utexas.edu" <pgoetz@math.utexas.edu>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: nfsd vurlerability submit
Message-ID: <20210113144026.GA1517953@infradead.org>
References: <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
 <20210112180326.GI9248@fieldses.org>
 <20210113081238.GA1428651@infradead.org>
 <0da3d3f1fee1a70eab3f78212f9282b03e21fc4d.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da3d3f1fee1a70eab3f78212f9282b03e21fc4d.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 13, 2021 at 02:34:45PM +0000, Trond Myklebust wrote:
> On Wed, 2021-01-13 at 08:12 +0000, Christoph Hellwig wrote:
> > FYI, if people really want to use some sort of subtree exports, for
> > XFS
> > (and probably ext4) we encode the project id into the file handle and
> > use the hierarchical project ID inheritance that we already use for
> > project quotas.
> 
> You'd basically need something along the lines of a NetApp qtree.
> 
> i.e. a persisted tag that can label all the files and directories in a
> subtree, and that is used to enforce a set of rules that are generally
> normally associated with filesystems. So no renames from objects inside
> the subtree to directories that lie outside it. No hard links that
> cross the subtree boundary.

That is the XFS project ID, which ext4 has also picked up a few years
ago.
