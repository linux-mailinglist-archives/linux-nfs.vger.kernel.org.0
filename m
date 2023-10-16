Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897137CAEB2
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjJPQQB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPQP7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 12:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF583
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697472911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCT777vyH/HkfICaGtesphSdXKWJK7uIOZSHPfC8LsE=;
        b=cs2LdQj6vTWgU2ZKYapbMw0Ayyb7K887h66SNrhQG1r0euSUMsRd0eMKBQ58yPq37mww5G
        6I29ZSKEPMU9DiMN6sVLN85zUWYluIMMrE3xkRSl6m+drAOFcfTIytaeKrmyM0heLiqO4I
        9/X0I6zxMIP+C+5jAF+OvYIdEGWvSfU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-JTgyK8LnOuic9_Fk6Lta5g-1; Mon, 16 Oct 2023 12:15:09 -0400
X-MC-Unique: JTgyK8LnOuic9_Fk6Lta5g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77422b20b13so73423685a.1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 09:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472909; x=1698077709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCT777vyH/HkfICaGtesphSdXKWJK7uIOZSHPfC8LsE=;
        b=HfJYlVU0tGXM/GyJKfu4jTbWUiIEj/gnVbbH5PNTR0bdI74yO3TW23fbCxgMbC3ZOp
         1+2VXKrHzhR5/OkLQCy31fGaDvmscSqIMqbJLZY/EfioyqhDatPM+YWHa3ee/A0Og1Bu
         Eh7tiGa9GhNQnWmNEqyruUlSORGz6OaeHo/YSAcpOiXB4Cm1XRdUs860QC3ZQhTro2b8
         jxx8DtqxWPv60mNr/js7f9aD4b/rmKpi0axxqAHuGKbw1PyzhLSiopb4ftuo1rkp4rTS
         Z37mPyrytTbLi76/XlW+OkaLKtk95QFrqMPcCUXGB82m2pL1yfoHfnJRkud2Xn7V5YOi
         wsJA==
X-Gm-Message-State: AOJu0Yw/ORDhn9iw5DODVykOsX/gwsFE3kHWgjAXsSkEau8G21aojMXy
        hUqUW4WYDxcM/dJl8vPaGSSNXY+NK5v2bERaArrgwOVEAhbrLVrw7EGP41JeAw84CLL+mvLyi9E
        U4AaKbFDxP7aV4NPqN2di
X-Received: by 2002:a05:620a:1787:b0:76f:167a:cc4d with SMTP id ay7-20020a05620a178700b0076f167acc4dmr38708979qkb.2.1697472908816;
        Mon, 16 Oct 2023 09:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRtBA7u70Rsr7WxYhpV3dlmm3c/dEvu6zHGuFWpLGS4PylcMtvRKiN8QAO0HZOWGAy0FBJMg==
X-Received: by 2002:a05:620a:1787:b0:76f:167a:cc4d with SMTP id ay7-20020a05620a178700b0076f167acc4dmr38708958qkb.2.1697472908516;
        Mon, 16 Oct 2023 09:15:08 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id pj35-20020a05620a1da300b0077589913a8bsm3068583qkn.132.2023.10.16.09.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 09:15:08 -0700 (PDT)
Message-ID: <82c3168c-acf3-469b-8065-d7731e7e62ff@redhat.com>
Date:   Mon, 16 Oct 2023 12:15:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] nfs-utils: gssd support for
 KRB5_AP_ERR_BAD_INTEGRITY
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/4/23 1:32 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Together with libtirpc patch this series attempts to provide
> support for handling KRB5_AP_ERR_BAD_INTEGRITY.
> 
> Such error can be returned by the server when it has changed
> its key material and the client is still using the service
> ticket that was issues prior to the change.
> 
> Upon calling authgss_create_default() and receiving a NULL
> context, we can inspect the returned structure to see
> if gss major/minor error code was set. If the client
> determines that it received KRB5_AP_ERR_BAD_INTEGRITY error,
> it will proceed to handle it based on what type of credentials
> were used for context establishement. If machine credentials
> were used, the client can call into a routine and force
> credential renewal. If user credentials were used, the client
> needs to remove the existing service ticket and then retry
> the request.
> 
> -- fix compile warning in libtirpc patch
> 
> Olga Kornievskaia (3):
>    gssd: enable forcing cred renewal using the keytab
>    gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
>    gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
Committed... (tag: nfs-utils-2-6-4-rc4)

steved.

> 
>   utils/gssd/gssd_proc.c | 20 ++++++++++++--
>   utils/gssd/krb5_util.c | 62 ++++++++++++++++++++++++++++++++++++------
>   utils/gssd/krb5_util.h |  4 ++-
>   3 files changed, 75 insertions(+), 11 deletions(-)
> 

