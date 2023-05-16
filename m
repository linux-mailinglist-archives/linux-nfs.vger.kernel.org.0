Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F252D704961
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 11:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjEPJeF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 16 May 2023 05:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjEPJeF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 05:34:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9245F1AE
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 02:34:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-135-X5UBcpsYPH-IDE9hxwtcdQ-1; Tue, 16 May 2023 10:34:00 +0100
X-MC-Unique: X5UBcpsYPH-IDE9hxwtcdQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 May
 2023 10:33:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 16 May 2023 10:33:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Azeem Shaikh' <azeemshaikh38@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
CC:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] NFSD: Remove open coding of string copy
Thread-Topic: [PATCH v3] NFSD: Remove open coding of string copy
Thread-Index: AQHZhtarLR7mMXSOG0mD9inDFwvZGq9cpMAQ
Date:   Tue, 16 May 2023 09:33:58 +0000
Message-ID: <d48a166d1cbc477f9cf063e91f7b3005@AcuMS.aculab.com>
References: <20230515024044.2677124-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230515024044.2677124-1-azeemshaikh38@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Azeem Shaikh
> Sent: 15 May 2023 03:41
> 
> Instead of open coding a __dynamic_array(), use the __string() and
> __assign_str() helper macros that exist for this kind of use case.

Is this actually a dynamic array, or just a char[8] ?
On 64 bit copying a short fixed-length string is far better
than any kind of dynamic sized allocation.

	David

> 
> Part of an effort to remove deprecated strlcpy() [1] completely from the
> kernel[2].
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  fs/nfsd/trace.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 4183819ea082..72a906a053dc 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
>  		__field(u32, cl_id)
>  		__field(unsigned long, authflavor)
>  		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
> -		__array(unsigned char, netid, 8)
> +		__string(netid, netid)
>  	),
>  	TP_fast_assign(
>  		__entry->cl_boot = clp->cl_clientid.cl_boot;
>  		__entry->cl_id = clp->cl_clientid.cl_id;
> -		strlcpy(__entry->netid, netid, sizeof(__entry->netid));
> +		__assign_str(netid, netid);
>  		__entry->authflavor = authflavor;
>  		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
>  				  clp->cl_cb_conn.cb_addrlen)
>  	),
>  	TP_printk("addr=%pISpc client %08x:%08x proto=%s flavor=%s",
>  		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
> -		__entry->netid, show_nfsd_authflavor(__entry->authflavor))
> +		__get_str(netid), show_nfsd_authflavor(__entry->authflavor))
>  );
> 
>  TRACE_EVENT(nfsd_cb_setup_err,
> --
> 2.40.1.606.ga4b1b128d6-goog
> 

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

