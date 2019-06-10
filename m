Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636E93B682
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2019 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390435AbfFJNx0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jun 2019 09:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390306AbfFJNx0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 Jun 2019 09:53:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38617308219E;
        Mon, 10 Jun 2019 13:53:26 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-83.phx2.redhat.com [10.3.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA6C5D6A9;
        Mon, 10 Jun 2019 13:53:25 +0000 (UTC)
Subject: Re: [PATCH 0/3] Incremental against [exports] rootdir patchset
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
References: <20190603171227.29148-1-trond.myklebust@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <418e1908-a552-faa7-5eee-7edbb8dfe251@RedHat.com>
Date:   Mon, 10 Jun 2019 09:53:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603171227.29148-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 10 Jun 2019 13:53:26 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/3/19 1:12 PM, Trond Myklebust wrote:
> These patches fix up a couple of bugs and issues against the [exports]
> rootdir patchset for nfs-utils.
> 
> Trond Myklebust (3):
>   mountd: Fix up incorrect comparison in next_mnt()
>   mountd: Ensure nfsd_path_strip_root() uses the canonicalised path
>   mountd: Canonicalise the rootdir in exportent_mkrealpath()
> 
>  support/export/export.c  | 12 ++++++++++--
>  support/misc/nfsd_path.c | 17 +++++++++++++----
>  utils/mountd/cache.c     |  2 +-
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
Committed!

steved.
