Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7268132EFA
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2020 20:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAGTGz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jan 2020 14:06:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47144 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728307AbgAGTGz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jan 2020 14:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578424014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWxhHK//rcBcFSuls00sx96LQKY1JxuNGToNs5GwtHE=;
        b=fVXvmnNxX4dmyKrTZvQK0A4bK2Qe1rOlImgx1ho08vOQxBPDKvYKROzwjr84hE637p7dwc
        88/DH31zPtqZUMswyekIzJWKyczPX9EsnAK0Ihqj8f+pQldRdiliRZzIeOcAOhxAgsxUR1
        42NNda1ucGQjmNF3VPIL9btBxZIEaLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-XMc0OE0bNWqMJngseAXjlw-1; Tue, 07 Jan 2020 14:06:51 -0500
X-MC-Unique: XMc0OE0bNWqMJngseAXjlw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C9C4101511B;
        Tue,  7 Jan 2020 19:06:50 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-217.phx2.redhat.com [10.3.117.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91F587BFBB;
        Tue,  7 Jan 2020 19:06:49 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 0/7] silence some warning in rpcgen
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <11af1233-d6e1-3952-475d-306dc5fefc06@RedHat.com>
Date:   Tue, 7 Jan 2020 14:06:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/3/20 4:50 PM, Giulio Benetti wrote:
> Since I'm trying to bump version of nfs-utils to latest in Buildroot, I've
> noticed some warning in rpcgen, so I've decided to clean them up by fixing
> code or #pragma ignoring them. Hope this is useful. Other warnings are
> still there waiting to be fixed and if you find these patches useful I'm
> going to complete all warning correction.
> 
> Giulio Benetti (7):
>   rpcgen: rpc_cout: silence unused def parameter
>   rpcgen: rpc_util: add storeval args to prototype
>   rpcgen: rpc_util: add findval args to prototype
>   rpcgen: rpc_parse: add get_definition() void argument
>   rpcgen: rpc_cout: fix potential -Wformat-nonliteral warning
>   rpcgen: rpc_hout: fix potential -Wformat-security warning
>   rpcgen: rpc_hout: fix indentation on f_print() argument separator
> 
>  tools/rpcgen/rpc_cout.c  | 8 ++++----
>  tools/rpcgen/rpc_hout.c  | 4 +++-
>  tools/rpcgen/rpc_parse.h | 2 +-
>  tools/rpcgen/rpc_util.h  | 4 ++--
>  4 files changed, 10 insertions(+), 8 deletions(-)
> 
Committed (tag: nfs-utils-2-4-3-rc5)

I must admit this code is actually being used... I assume they do the right thing...

The rpcgen we been using is the old one that came out 
of the glibc code at https://github.com/thkukuk/rpcsvc-proto

I wonder what the difference is.... 

steved.

