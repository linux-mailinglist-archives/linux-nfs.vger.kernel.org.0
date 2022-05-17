Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71E552A8C3
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 19:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351283AbiEQRBI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 May 2022 13:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351326AbiEQRBD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 May 2022 13:01:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E750443
        for <linux-nfs@vger.kernel.org>; Tue, 17 May 2022 10:01:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j25so24585436wrc.9
        for <linux-nfs@vger.kernel.org>; Tue, 17 May 2022 10:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wkRNIbiVVY6pE2pAXqEa8b6R2fwz5xN9ZF/d/niJWbw=;
        b=Xm0TBP7NWHPmjkbVfdh5Oq16SN5NGiN7iW2GH7vamKuGX2leNqG28cwZh4QnPnC+U8
         7mbG+Tz+tOOlDRb9C4qRhzg0LhvayxlRg9V+q6TGlaYRN7E/qkvwaSLym29Kg3LN//rs
         x1og40qirnGtoUxKaqGsUaihTCLNDzC6xxw0HlCTEuzVdpyYWRR1dhkfayY51M77PUJj
         uQ0vBhCzDkgBs63x+7WfMKCSq2VEc9kbxOURx6aWvzfbUe0k3s+Dp1UwM2MMJvOEjXDL
         IOloNBKt192+99dkTnVYcT4bd2q1SuxlZU9JZ5m9KfxHonXtXAN7DGF77xAk24+DtJWj
         2jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wkRNIbiVVY6pE2pAXqEa8b6R2fwz5xN9ZF/d/niJWbw=;
        b=0yQf6jzMxBaeIY2VpaTitSLpDN25JDXwcTHWmHHmT5XVT+Dw7im3koA68QUa7vxrwu
         VNaZ+rQAUqM3hliqARXYp5EVBBHPuwl4UcVtBHy0oi7HV/RJ5Y/2N3P7HI37e4JNzKgu
         LE0TKyl7IoeoMMQdlqLNgwvDFLdue2y6Qs9LPhsaqlnjsF82VHP1RgO96AD5A+KDuZ5p
         sVtudiuOqyZHTq8D9ho8igKFfn642lRLup9r+vj/lY7rXo4DTzQ67ZvzvwOCo+BSY0a6
         nc0R6BaC1NGsKnXHeW5RVmjCpdid/roYsFWDijV1f/IIH6FhlUA+2zwK/BvPa6mxB2g+
         HYdg==
X-Gm-Message-State: AOAM531fqnfv8ZabrhKo8OKwhy40cD7xY51xbDPptYh4sE8RH2H95lf7
        y5ajYPLhbb9zZv/jq2IPB2TkAksYzjWvLA==
X-Google-Smtp-Source: ABdhPJwo9JUiQMEK17lAyzd/+WqYvBZF/m7HGqxLY7lmGl3xXfHvJxOWdImwrZ6V131rzN19f7Drrg==
X-Received: by 2002:a5d:584b:0:b0:20c:6317:1f77 with SMTP id i11-20020a5d584b000000b0020c63171f77mr19777186wrf.355.1652806860344;
        Tue, 17 May 2022 10:01:00 -0700 (PDT)
Received: from gmail.com ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id q1-20020adf9dc1000000b0020e5b4ebaecsm1538308wre.4.2022.05.17.10.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:00:59 -0700 (PDT)
Date:   Tue, 17 May 2022 20:00:57 +0300
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Trond Myklebust <trond.myklebust@primarydata.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/9] NFSv4: Clean up encode_attrs
Message-ID: <20220517170057.lt6prmdl2kaupo54@gmail.com>
References: <20180320210313.94429-1-trond.myklebust@primarydata.com>
 <20180320210313.94429-2-trond.myklebust@primarydata.com>
 <20180320210313.94429-3-trond.myklebust@primarydata.com>
 <20180320210313.94429-4-trond.myklebust@primarydata.com>
 <20180320210313.94429-5-trond.myklebust@primarydata.com>
 <20180320210313.94429-6-trond.myklebust@primarydata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320210313.94429-6-trond.myklebust@primarydata.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

Wireshark claims that this commit broke encoding of SETATTR (see below).

Is Wireshark correct in reference to the RFC?

Frame 56: 274 bytes on wire (2192 bits), 274 bytes captured (2192 bits)
Ethernet II, Src: RealtekU_d0:d8:ff (52:54:00:d0:d8:ff), Dst: RealtekU_7a:80:63 (52:54:00:7a:80:63)
Internet Protocol Version 4, Src: 192.168.40.1, Dst: 192.168.40.11
Transmission Control Protocol, Src Port: 999, Dst Port: 2049, Seq: 4325, Ack: 4489, Len: 208
Remote Procedure Call, Type:Call XID:0x3725a760
Network File System, Ops(4): SEQUENCE, PUTFH, SETATTR, GETATTR
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
    minorversion: 1
    Operations (count: 4): SEQUENCE, PUTFH, SETATTR, GETATTR
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: SETATTR (34)
            StateID
                [StateID Hash: 0xafa9]
                StateID seqid: 0
                StateID Other: 000000000000000000000000
                [StateID Other hash: 0x60de]
            [Expert Info (Warning/Protocol): Per RFCs 3530 and 5661 an attribute mask is required but was not provided.]
                [Per RFCs 3530 and 5661 an attribute mask is required but was not provided.]
                [Severity level: Warning]
                [Group: Protocol]
        Opcode: GETATTR (9)
    [Main Opcode: SETATTR (34)]

0000  52 54 00 7a 80 63 52 54 00 d0 d8 ff 08 00 45 00   RT.z.cRT......E.
0010  01 04 a6 16 40 00 40 06 c2 80 c0 a8 28 01 c0 a8   ....@.@.....(...
0020  28 0b 03 e7 08 01 14 fe a6 02 de f4 09 10 80 18   (...............
0030  01 7b d2 53 00 00 01 01 08 0a 68 ba 83 03 e9 ee   .{.S......h.....
0040  7c 0b 80 00 00 cc 37 25 a7 60 00 00 00 00 00 00   |.....7%.`......
0050  00 02 00 01 86 a3 00 00 00 04 00 00 00 01 00 00   ................
0060  00 01 00 00 00 30 00 41 88 3d 00 00 00 16 63 6c   .....0.A.=....cl
0070  69 65 6e 74 2e 6e 66 73 2d 74 65 73 74 69 6e 67   ient.nfs-testing
0080  2e 63 6f 6d 00 00 00 00 00 00 00 00 00 00 00 00   .com............
0090  00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
00a0  00 00 00 00 00 01 00 00 00 04 00 00 00 35 37 00   .............57.
00b0  00 00 00 a0 00 00 36 00 00 00 00 a0 00 00 00 00   ......6.........
00c0  00 14 00 00 00 00 00 00 00 00 00 00 00 01 00 00   ................
00d0  00 16 00 00 00 10 00 00 69 8d 44 d8 0e 34 0f 7d   ........i.D..4.}
00e0  00 00 00 00 00 00 00 00 00 22 00 00 00 00 00 00   ........."......
00f0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
0100  00 00 00 00 00 09 00 00 00 02 00 10 01 1a 00 30   ...............0
0110  a2 3a                                             .:

On 2018-03-20 17:03:09, Trond Myklebust wrote:
> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
> ---
>  fs/nfs/nfs4xdr.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 80c5b519fd6a..3d088230c975 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1052,9 +1052,7 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
>  	int owner_namelen = 0;
>  	int owner_grouplen = 0;
>  	__be32 *p;
> -	unsigned i;
>  	uint32_t len = 0;
> -	uint32_t bmval_len;
>  	uint32_t bmval[3] = { 0 };
>  
>  	/*
> @@ -1123,19 +1121,8 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
>  		bmval[2] |= FATTR4_WORD2_SECURITY_LABEL;
>  	}
>  
> -	if (bmval[2] != 0)
> -		bmval_len = 3;
> -	else if (bmval[1] != 0)
> -		bmval_len = 2;
> -	else
> -		bmval_len = 1;
> -
> -	p = reserve_space(xdr, 4 + (bmval_len << 2) + 4 + len);
> -
> -	*p++ = cpu_to_be32(bmval_len);
> -	for (i = 0; i < bmval_len; i++)
> -		*p++ = cpu_to_be32(bmval[i]);
> -	*p++ = cpu_to_be32(len);
> +	xdr_encode_bitmap4(xdr, bmval, ARRAY_SIZE(bmval));
> +	xdr_stream_encode_opaque_inline(xdr, (void **)&p, len);
>  
>  	if (bmval[0] & FATTR4_WORD0_SIZE)
>  		p = xdr_encode_hyper(p, iap->ia_size);
> -- 
> 2.14.3
> 

-- 
Dan Aloni
