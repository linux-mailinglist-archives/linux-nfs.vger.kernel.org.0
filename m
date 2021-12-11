Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DFF4713AC
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Dec 2021 12:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhLKLjd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Dec 2021 06:39:33 -0500
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:60390 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhLKLjd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 11 Dec 2021 06:39:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0713852|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00485452-6.23715e-05-0.995083;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.M9Z1.tG_1639222771;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.M9Z1.tG_1639222771)
          by smtp.aliyun-inc.com(10.147.44.118);
          Sat, 11 Dec 2021 19:39:31 +0800
Date:   Sat, 11 Dec 2021 19:39:36 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Subject: Re: [PATCH 0/7] NFSv4.1+ support for session trunking discovery
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
In-Reply-To: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
References: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
Message-Id: <20211211193935.C17A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

We need a option to control active-active or active-standby mode?
1) active-active    will get better performance when 10GbE/25GbE ports?
2) active-standby will get better performance when 100GbE/40GbE ports?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/12/11

> From: Olga Kornievskaia <kolga@netapp.com>
> 
> This patch series adds session trunking discovery and setup. When a
> client discovers a new file system in addition to probing for
> existing attributes, it also sends a GETATTR asking for an fs_location
> attribute. If it receives a non-zero length reply, it will iterate
> thru the response and, for each server location, it will establish a
> connection (of the same type as the existing RPC transport), send
> an EXCHANGE_ID, and test for session trunking. If the trunking test
> succeeds, the transport is added to an existing set of transports
> for this server. 
> 
> Olga Kornievskaia (7):
>   NFSv4 remove zero number of fs_locations entries error check
>   NFSv4 store server support for fs_location attribute
>   NFSv4.1 query for fs_location attr on a new file system
>   NFSv4 expose nfs_parse_server_name function
>   NFSv4 handle port presence in fs_location server string
>   SUNRPC allow for unspecified transport time in rpc_clnt_add_xprt
>   NFSv4.1 test and add 4.1 trunking transport
> 
>  fs/nfs/client.c           |   7 ++
>  fs/nfs/nfs4_fs.h          |  12 ++--
>  fs/nfs/nfs4namespace.c    |  19 ++++--
>  fs/nfs/nfs4proc.c         | 131 +++++++++++++++++++++++++++++++++++---
>  fs/nfs/nfs4state.c        |   6 +-
>  fs/nfs/nfs4xdr.c          |   2 -
>  include/linux/nfs_fs_sb.h |   2 +-
>  include/linux/nfs_xdr.h   |   1 +
>  net/sunrpc/clnt.c         |   5 +-
>  9 files changed, 158 insertions(+), 27 deletions(-)
> 
> -- 
> 2.27.0


