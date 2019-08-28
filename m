Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B987A0858
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfH1R2u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 13:28:50 -0400
Received: from fieldses.org ([173.255.197.46]:49336 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1R2u (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 13:28:50 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 9A2F7BD8; Wed, 28 Aug 2019 13:28:49 -0400 (EDT)
Date:   Wed, 28 Aug 2019 13:28:49 -0400
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc:     linux-nfs@vger.kernel.org, cuiyue-fnst@cn.fujitsu.com
Subject: Re: NFS issues about aio and dio test
Message-ID: <20190828172849.GA29148@fieldses.org>
References: <975395cc-62f2-843f-cc71-82339b2869cd@cn.fujitsu.com>
 <65ea4ea2-548f-1546-059a-af901bba2e87@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65ea4ea2-548f-1546-059a-af901bba2e87@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 26, 2019 at 08:37:41AM +0800, Su Yanjun wrote:
> Any ping?
> 
> 在 2019/8/6 14:08, Su Yanjun 写道:
> >Hi,
> >
> >When I tested xfstests generic/465 with NFS, there was something
> >unexpected.
> >
> >When memory of NFS server was 10G, test passed.
> >But when memory of NFS server was 4G, test failed.
> >
> >Fail message was as below.
> >    non-aio dio test
> >    encounter an error: block 4 offset 0, content 62
> >    aio-dio test
> >    encounter an error: block 1 offset 0, content 62
> >
> >All of the NFS versions(v3 v4.0 v4.1 v4.2) have  this problem.
> >Maybe something is wrong about NFS's I/O operation.
> >
> >Thanks in advance.

Off the top of my head it doesn't look familiar.

What kernel version are you running on client and server?

Did this test previously pass on an older kernel (so, was this a recent
regression?)

Have you looked at generic/465 to see what exactly is happening here?

--b.
