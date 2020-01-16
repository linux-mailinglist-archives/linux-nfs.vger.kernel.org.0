Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CA313FABB
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 21:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgAPUhT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 15:37:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729637AbgAPUhT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 15:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579207037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iVm5siUgNEl1GmahPKZ6dlgKYiTCzVICm9bnX+fF30=;
        b=Q6ryb+H5zBncptQiTX3y5Ol80XoSbRzZKBOQjdjv+FQPeZfUJjlkJjN3E7DAK9WxzVXtPM
        Rp8ZuuQgTmdab89mz9NcFXZ/g7cFeSafoaSeTxidx9/9oPgPnfbdFXgGSUAOsblBbiriq4
        iDdifO15sE29RChsls5wI9H9+bfb/5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-6pZ-36pMPUOcpwgYh47dXw-1; Thu, 16 Jan 2020 15:37:16 -0500
X-MC-Unique: 6pZ-36pMPUOcpwgYh47dXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 440D6800D48;
        Thu, 16 Jan 2020 20:37:15 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-35.phx2.redhat.com [10.3.117.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3467390;
        Thu, 16 Jan 2020 20:37:14 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 0/3] bump rpcgen version and silence some
 warning
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     linux-nfs@vger.kernel.org
References: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <30b28d4e-71a5-f412-23e7-877a4eff17bd@RedHat.com>
Date:   Thu, 16 Jan 2020 15:37:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/13/20 11:29 AM, Giulio Benetti wrote:
> Giulio Benetti (3):
>   rpcgen: bump to latest version
>   rpcgen: rpc_cout: silence format-nonliteral
>   support: nfs: rpc_socket: silence unused parameter warning on salen
> 
>  support/nfs/rpc_socket.c   |    2 +
>  tools/rpcgen/Makefile.am   |   24 +-
>  tools/rpcgen/proto.h       |   65 ++
>  tools/rpcgen/rpc_clntout.c |  458 +++++---
>  tools/rpcgen/rpc_cout.c    | 1269 ++++++++++++----------
>  tools/rpcgen/rpc_hout.c    |  915 +++++++++-------
>  tools/rpcgen/rpc_main.c    | 2083 +++++++++++++++++++++---------------
>  tools/rpcgen/rpc_parse.c   | 1055 +++++++++---------
>  tools/rpcgen/rpc_parse.h   |  103 +-
>  tools/rpcgen/rpc_sample.c  |  465 ++++----
>  tools/rpcgen/rpc_scan.c    |  812 +++++++-------
>  tools/rpcgen/rpc_scan.h    |   91 +-
>  tools/rpcgen/rpc_svcout.c  | 1647 +++++++++++++++-------------
>  tools/rpcgen/rpc_tblout.c  |  265 ++---
>  tools/rpcgen/rpc_util.c    |  656 ++++++------
>  tools/rpcgen/rpc_util.h    |  170 ++-
>  tools/rpcgen/rpcgen.1      |  442 ++++++++
>  17 files changed, 6123 insertions(+), 4399 deletions(-)
>  create mode 100644 tools/rpcgen/proto.h
>  create mode 100644 tools/rpcgen/rpcgen.1
> 
Committed... (tag nfs-utils-2-4-3-rc5)... Nice work!!!

steved.

