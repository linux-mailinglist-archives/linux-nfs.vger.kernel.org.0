Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E48037948C
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEJQvE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 12:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230165AbhEJQvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 May 2021 12:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620665398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwfMClAQ0WDWqloBCT9ONe4H0OedQU+pWdkBppNl4cE=;
        b=UEJ6iDVGoGEe4Zw9jhYOV+qJyI+eQ1yzbx5CFM27jtZtDlcp7DRccsPHc02kOgucOBEfuZ
        xoUkJOk2hdtU1ZpKRz7+FFL1Aff589qUObdO0f6ZrfVLgy93wBQITscqkaPj2AjIhpb+ca
        981tCbpajekpmSFYqhArNF5vmrj8PCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-A561w8-lOcaaW6VcwVj3Yw-1; Mon, 10 May 2021 12:49:56 -0400
X-MC-Unique: A561w8-lOcaaW6VcwVj3Yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8410D6D4EE;
        Mon, 10 May 2021 16:49:54 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-61.phx2.redhat.com [10.3.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E77025D6DC;
        Mon, 10 May 2021 16:49:53 +0000 (UTC)
Subject: Re: [PATCH] Replace the final SunRPC licenses with BSD licenses
From:   Steve Dickson <SteveD@RedHat.com>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Tom 'spot' Callaway <spotrh@gmail.com>
References: <20210505164926.29968-1-steved@redhat.com>
Message-ID: <2737da91-aa62-1539-80aa-48ff1137e3d1@RedHat.com>
Date:   Mon, 10 May 2021 12:52:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210505164926.29968-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/5/21 12:49 PM, Steve Dickson wrote:
> From: Tom 'spot' Callaway <spotrh@gmail.com>
> 
> It was noticed there was a couple SunRPC licenses
> were left from the work that was done in 2009-2010
> (ea26246^..ba3945e). This converts them to BSD licenses.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1955239
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed (tag: libtirpc-1-3-2-rc3)

steved.
> ---
>  tirpc/rpc/key_prot.h    | 49 ++++++++++++++--------------
>  tirpc/rpcsvc/key_prot.x | 71 ++++++++++++++++++++---------------------
>  2 files changed, 60 insertions(+), 60 deletions(-)
> 
> diff --git a/tirpc/rpc/key_prot.h b/tirpc/rpc/key_prot.h
> index ff852dc..fd5a6c5 100644
> --- a/tirpc/rpc/key_prot.h
> +++ b/tirpc/rpc/key_prot.h
> @@ -13,33 +13,34 @@
>  extern "C" {
>  #endif
>  
> -/*
> - * Sun RPC is a product of Sun Microsystems, Inc. and is provided for
> - * unrestricted use provided that this legend is included on all tape
> - * media and as a part of the software program in whole or part.  Users
> - * may copy or modify Sun RPC without charge, but are not authorized
> - * to license or distribute it to anyone else except as part of a product or
> - * program developed by the user.
> - *
> - * SUN RPC IS PROVIDED AS IS WITH NO WARRANTIES OF ANY KIND INCLUDING THE
> - * WARRANTIES OF DESIGN, MERCHANTIBILITY AND FITNESS FOR A PARTICULAR
> - * PURPOSE, OR ARISING FROM A COURSE OF DEALING, USAGE OR TRADE PRACTICE.
> - *
> - * Sun RPC is provided with no support and without any obligation on the
> - * part of Sun Microsystems, Inc. to assist in its use, correction,
> - * modification or enhancement.
> +/* Copyright (c) 2010, Oracle America, Inc.
>   *
> - * SUN MICROSYSTEMS, INC. SHALL HAVE NO LIABILITY WITH RESPECT TO THE
> - * INFRINGEMENT OF COPYRIGHTS, TRADE SECRETS OR ANY PATENTS BY SUN RPC
> - * OR ANY PART THEREOF.
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are
> + * met:
>   *
> - * In no event will Sun Microsystems, Inc. be liable for any lost revenue
> - * or profits or other special, indirect and consequential damages, even if
> - * Sun has been advised of the possibility of such damages.
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above
> + *       copyright notice, this list of conditions and the following
> + *       disclaimer in the documentation and/or other materials
> + *       provided with the distribution.
> + *     * Neither the name of the "Oracle America, Inc." nor the names of its
> + *       contributors may be used to endorse or promote products derived
> + *       from this software without specific prior written permission.
>   *
> - * Sun Microsystems, Inc.
> - * 2550 Garcia Avenue
> - * Mountain View, California  94043
> + *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + *   FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> + *   COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
> + *   INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + *   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> + *   GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + *   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
> + *   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
> + *   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  #if 0
>  #pragma ident "@(#)key_prot.x	1.7	94/04/29 SMI"
> diff --git a/tirpc/rpcsvc/key_prot.x b/tirpc/rpcsvc/key_prot.x
> index 63c1bbc..9baf943 100644
> --- a/tirpc/rpcsvc/key_prot.x
> +++ b/tirpc/rpcsvc/key_prot.x
> @@ -1,34 +1,33 @@
> -%/*
> -% * Sun RPC is a product of Sun Microsystems, Inc. and is provided for
> -% * unrestricted use provided that this legend is included on all tape
> -% * media and as a part of the software program in whole or part.  Users
> -% * may copy or modify Sun RPC without charge, but are not authorized
> -% * to license or distribute it to anyone else except as part of a product or
> -% * program developed by the user.
> -% *
> -% * SUN RPC IS PROVIDED AS IS WITH NO WARRANTIES OF ANY KIND INCLUDING THE
> -% * WARRANTIES OF DESIGN, MERCHANTIBILITY AND FITNESS FOR A PARTICULAR
> -% * PURPOSE, OR ARISING FROM A COURSE OF DEALING, USAGE OR TRADE PRACTICE.
> -% *
> -% * Sun RPC is provided with no support and without any obligation on the
> -% * part of Sun Microsystems, Inc. to assist in its use, correction,
> -% * modification or enhancement.
> -% *
> -% * SUN MICROSYSTEMS, INC. SHALL HAVE NO LIABILITY WITH RESPECT TO THE
> -% * INFRINGEMENT OF COPYRIGHTS, TRADE SECRETS OR ANY PATENTS BY SUN RPC
> -% * OR ANY PART THEREOF.
> -% *
> -% * In no event will Sun Microsystems, Inc. be liable for any lost revenue
> -% * or profits or other special, indirect and consequential damages, even if
> -% * Sun has been advised of the possibility of such damages.
> -% *
> -% * Sun Microsystems, Inc.
> -% * 2550 Garcia Avenue
> -% * Mountain View, California  94043
> -% */
>  /*
>   * Key server protocol definition
> - * Copyright (C) 1990, 1991 Sun Microsystems, Inc.
> + * Copyright (c) 2010, Oracle America, Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are
> + * met:
> + *
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above
> + *       copyright notice, this list of conditions and the following
> + *       disclaimer in the documentation and/or other materials
> + *       provided with the distribution.
> + *     * Neither the name of the "Oracle America, Inc." nor the names of its
> + *       contributors may be used to endorse or promote products derived
> + *       from this software without specific prior written permission.
> + *
> + *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + *   FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> + *   COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
> + *   INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + *   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> + *   GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + *   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
> + *   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
> + *   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   *
>   * The keyserver is a public key storage/encryption/decryption service
>   * The encryption method used is based on the Diffie-Hellman exponential
> @@ -87,7 +86,7 @@ enum keystatus {
>  	KEY_SUCCESS,	/* no problems */
>  	KEY_NOSECRET,	/* no secret key stored */
>  	KEY_UNKNOWN,	/* unknown netname */
> -	KEY_SYSTEMERR	/* system error (out of memory, encryption failure) */
> +	KEY_SYSTEMERR 	/* system error (out of memory, encryption failure) */
>  };
>  
>  typedef opaque keybuf[HEXKEYBYTES];	/* store key in hex */
> @@ -171,7 +170,7 @@ program KEY_PROG {
>  
>  		/*
>  		 * This is my secret key.
> -		 * Store it for me.
> +	 	 * Store it for me.
>  		 */
>  		keystatus
>  		KEY_SET(keybuf) = 1;
> @@ -179,7 +178,7 @@ program KEY_PROG {
>  		/*
>  		 * I want to talk to X.
>  		 * Encrypt a conversation key for me.
> -		 */
> +	 	 */
>  		cryptkeyres
>  		KEY_ENCRYPT(cryptkeyarg) = 2;
>  
> @@ -213,7 +212,7 @@ program KEY_PROG {
>  
>  		/*
>  		 * This is my secret key.
> -		 * Store it for me.
> +	 	 * Store it for me.
>  		 */
>  		keystatus
>  		KEY_SET(keybuf) = 1;
> @@ -221,7 +220,7 @@ program KEY_PROG {
>  		/*
>  		 * I want to talk to X.
>  		 * Encrypt a conversation key for me.
> -		 */
> +	 	 */
>  		cryptkeyres
>  		KEY_ENCRYPT(cryptkeyarg) = 2;
>  
> @@ -248,7 +247,7 @@ program KEY_PROG {
>  		/*
>  		 * I want to talk to X. and I know X's public key
>  		 * Encrypt a conversation key for me.
> -		 */
> +	 	 */
>  		cryptkeyres
>  		KEY_ENCRYPT_PK(cryptkeyarg2) = 6;
>  
> @@ -268,7 +267,7 @@ program KEY_PROG {
>  		/*
>  		 * Retrieve my public key, netname and private key.
>  		 */
> -		key_netstres
> + 		key_netstres
>  		KEY_NET_GET(void) = 9;
>  
>  		/*
> 

