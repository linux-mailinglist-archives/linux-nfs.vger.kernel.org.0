Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765F8927CC
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHSPB6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 11:01:58 -0400
Received: from fieldses.org ([173.255.197.46]:39080 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfHSPB6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Aug 2019 11:01:58 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 164EC1E19; Mon, 19 Aug 2019 11:01:58 -0400 (EDT)
Date:   Mon, 19 Aug 2019 11:01:58 -0400
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Cache open file descriptors in knfsd
Message-ID: <20190819150158.GB18075@fieldses.org>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Aug 18, 2019 at 02:18:43PM -0400, Trond Myklebust wrote:
> v2:
> - Fix a double semicolon in fs/nfsd/filecache.c
> - Adjust changelog for "nfsd: rip out the raparms cache" as per Chuck's
>   request.

Thanks, replaced the series in my -next branch with this version.

--b.
