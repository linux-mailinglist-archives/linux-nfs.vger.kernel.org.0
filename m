Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE81145B37
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 18:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgAVR5D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 12:57:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29272 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbgAVR5D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 12:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579715821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cS0uoY/xlEBJl8b6UtmYQIw7oAy+BeSSU7SgqZtjLXA=;
        b=ggDkLiE3ZP3kYkwiBaRP/KWTk2AOwDABJoit+Isd7BmEY4+D08ELyawDGlRG78Kyhfl6e2
        pecrsE7viUHfMyvJoW7tnqI4NfyS9fhYb2TEvicwq11I9Wqm56OBtnRy9hrtiy4PL0veYi
        os0cdzfOMpzoXt6smEzEpn7+65FnH6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-IjXfIMmSNGuAndvIFu3sGw-1; Wed, 22 Jan 2020 12:56:57 -0500
X-MC-Unique: IjXfIMmSNGuAndvIFu3sGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74860193101A;
        Wed, 22 Jan 2020 17:56:56 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EDBE60F8D;
        Wed, 22 Jan 2020 17:56:56 +0000 (UTC)
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler
 costraint
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
References: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <ae36c91f-bed4-3839-bdd5-fffdcca9bf40@RedHat.com>
Date:   Wed, 22 Jan 2020 12:56:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/15/20 11:08 AM, Giulio Benetti wrote:
> Currently locktest can be built only for host because CC_FOR_BUILD is
> specified as CC, but this leads to build failure when passing CFLAGS not
> available on host gcc(i.e. -mlongcalls) and most of all locktest would
> be available on target systems the same way as rpcgen etc. So remove CC
> and LIBTOOL assignments.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Committed... (tag: nfs-utils-2-4-3-rc6)

steved.
> ---
>  tools/locktest/Makefile.am | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
> index 3156815d..e8914655 100644
> --- a/tools/locktest/Makefile.am
> +++ b/tools/locktest/Makefile.am
> @@ -1,8 +1,5 @@
>  ## Process this file with automake to produce Makefile.in
>  
> -CC=$(CC_FOR_BUILD)
> -LIBTOOL = @LIBTOOL@ --tag=CC
> -
>  noinst_PROGRAMS = testlk
>  testlk_SOURCES = testlk.c
>  testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
> 

