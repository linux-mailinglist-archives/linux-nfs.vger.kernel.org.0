Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB233CF474
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jul 2021 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhGTFob (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jul 2021 01:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241994AbhGTFo2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jul 2021 01:44:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E3BC061574;
        Mon, 19 Jul 2021 23:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gi3dKQNPawi4I2tSsGsNy/bQDTWLIwmslwDooDCtDjw=; b=lnyaYhqO0uP8fA2gybDeSa0Lf8
        5UjzJH40WTFON8EkfFcY7qokkC9kyeFLr9yUp3Lnb/G/SMUZaXUh+NpcrPOOo6eWUyq3s+KIn+Hfy
        q5oP5D1syun10HhXkkykZMiZciis007AH3x/7iffyUJqK+At3Zm7m+h5CYNIBC7fF6EJ7fc3BXrUq
        yPWcVd9z16zCGVos6cE7vJ8s9SoDp3F+aGYJDltjXFLyaysqhiGzSfcQ2anlaOA/W9G5Qbe4hCg7Z
        /nh02Lp9ThK2afUXRLCUE7zZ4t0p+rAO6Zz8aAoZ4Kjo8ZKYICslKoKy8U1bMCeghzwC7Ly/jfNPl
        qto45Jrg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jAV-007p0v-6h; Tue, 20 Jul 2021 06:23:57 +0000
Date:   Tue, 20 Jul 2021 07:23:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
Message-ID: <YPZr9woK584Oc61H@infradead.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
 <YPBmGknHpFb06fnD@infradead.org>
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
 <YPBvUfCNmv0ElBpo@infradead.org>
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
 <YPVC/w4kw3y/14oF@infradead.org>
 <162673888433.4136.7451392112850411713@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162673888433.4136.7451392112850411713@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 20, 2021 at 09:54:44AM +1000, NeilBrown wrote:
> Do you have any pointers to other breakage caused by this particular
> behaviour of btrfs? It would to have all requirements clearly on the
> table while designing a solution.

A quick google find:

https://lore.kernel.org/linux-btrfs/b5e7e64a-741c-baee-bc4d-cd51ca9b3a38@gmail.com/T/
https://savannah.gnu.org/bugs/?50859
https://github.com/coreos/bugs/issues/301
https://bugs.kde.org/show_bug.cgi?id=317127
https://github.com/borgbackup/borg/issues/4009
https://bugs.python.org/issue37339
http://mail.openjdk.java.net/pipermail/nio-dev/2017-June/004292.html

and that is just the first 2 or three pages of trivial search results.
