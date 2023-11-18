Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924657F02F0
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 21:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjKRUqA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 15:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRUqA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 15:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8EC5
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 12:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700340354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QFcnEcT+K5o/H40wSq4qTGeizcRFz+lDoyWvLBJgXyo=;
        b=G73tJ2fAe9nMCLjnQfnFj7+rKwF9jY9VOaW/chkpAj8SH0uF3zoFcbIaFov5HlfJZBlzX+
        V+WuELirmXOrtaRUwcJRcG/MLmlGoRy4S6mRTb2oT96nZ9GxTP3z7gFnl8dRpLSpInS59O
        KvX+ZW/i2jU8qRxG3+fjFyiV9LFBPjY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-GvdounidNGifKCIkPrz-og-1; Sat, 18 Nov 2023 15:45:53 -0500
X-MC-Unique: GvdounidNGifKCIkPrz-og-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ef39189888so776054fac.1
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 12:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700340352; x=1700945152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFcnEcT+K5o/H40wSq4qTGeizcRFz+lDoyWvLBJgXyo=;
        b=tx4p5mfbrP6a9+BAhnSPWmD/pmvWThPgKMpiSKvZGjjE3dVxd7/Qf45MamL+RKRb+h
         t0zWh3SEeMgbywpRDLzXzFN26IVenmWKLua2QHquAOCt/vJ3HWpvBBItqeTjUi30E49G
         3v9CbvEb/crO+uPQe/68ykTwsACDTM3ZOnR79HEQJS/WB6uq1M+dEtOBCtnO1U1E0s7u
         yfeFMumB2CrUxHSBU0VObbYL9ChYMHgGdZbMUmrd+mwrMsImXRoSik723DzgbjXEIw81
         dkLCl6sQN2Ry9GmcGr7/7OEEpZ9e5oMyHsQ4FFBEdLijdy2FkhrPvjKFaCNRL1H9kwdF
         xxsQ==
X-Gm-Message-State: AOJu0YyYOAJMJUy/yAdKG/+z4gA/iLkBP2gq8VSGQeKDq2EGDxmcFscY
        Hoy0DhiCfWrzBWKFecG2rH4YAasOJX2vUWez2iw+lPU0zLm7v5FDGrg8EmoJ18Ktm82AoMJXDIy
        5VUzS2F9ePkYghqJ0NK7m0cITFdnL
X-Received: by 2002:a05:6358:6f11:b0:16b:9612:1210 with SMTP id r17-20020a0563586f1100b0016b96121210mr3380993rwn.1.1700340352130;
        Sat, 18 Nov 2023 12:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCgKi3iiR5sDcJ2vVSNzmylsB7AstAcBfUCDC9VO5rvjhCawdRqUP5u6cRgRlCaFOmdmWx7A==
X-Received: by 2002:a05:6358:6f11:b0:16b:9612:1210 with SMTP id r17-20020a0563586f1100b0016b96121210mr3380985rwn.1.1700340351794;
        Sat, 18 Nov 2023 12:45:51 -0800 (PST)
Received: from [172.31.1.12] ([70.109.136.127])
        by smtp.gmail.com with ESMTPSA id o1-20020ac85541000000b0041b9b6eb309sm1477240qtr.93.2023.11.18.12.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 12:45:51 -0800 (PST)
Message-ID: <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
Date:   Sat, 18 Nov 2023 15:45:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/18/23 12:03 PM, Chuck Lever III wrote:
> 
>> On Nov 18, 2023, at 11:49 AM, Trond Myklebust <trondmy@hammerspace.com> wrote:
>>
>> On Sat, 2023-11-18 at 16:41 +0000, Chuck Lever III wrote:
>>>
>>>> On Nov 18, 2023, at 1:42 AM, Cedric Blancher
>>>> <cedric.blancher@gmail.com> wrote:
>>>>
>>>> On Fri, 17 Nov 2023 at 08:42, Cedric Blancher
>>>> <cedric.blancher@gmail.com> wrote:
>>>>>
>>>>> How owns bugzilla.linux-nfs.org?
>>>>
>>>> Apologies for the type, it should be "who", not "how".
>>>>
>>>> But the problem remains, I still did not get an account creation
>>>> token
>>>> via email for *ANY* of my email addresses. It appears account
>>>> creation
>>>> is broken.
>>>
>>> Trond owns it. But he's already showed me the SMTP log from
>>> Sunday night: a token was sent out. Have you checked your
>>> spam folders?
>>
>> I'm closing it down. It has been run and paid for by me, but I don't
>> have time or resources to keep doing so.
> 
> Understood about lack of resources, but is there no-one who can
> take over for you, at least in the short term? Yanking it out
> without warning is not cool.
> 
> Does this announcement include git.linux-nfs.org <http://git.linux-nfs.org/> and
> wiki.linux-nfs.org <http://wiki.linux-nfs.org/> as well?
> 
> As this site is a long-time community-used resource, it would
> be fair if we could come up with a transition plan if it truly
> needs to go away.

If you need resources and time... Please reach out...

This is a community... I'm sure we can figure something out.
But please turn it back on.

steved.

