Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947EA7EA30E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 19:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjKMStU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 13:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMStT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 13:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E458010E2
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699901331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NngWT0kzCoGFN4QlS8k8mPScf3kiilywOIlG1/GqBxM=;
        b=QixTlTnBJrDpe1gW/7+c2YZnQGD6naqqi9COKNvcKfoqRmI26CrDC2jKme8/hUzL3ezFd/
        Kk/oKwCoTKGaPySWX4pPGVr3s4x9kyh1FGGbDifKFRpLvPvlH0AHmKlu7GziHhYX9H2cXm
        JIE32D3cV407/GqG7/vOK4xtAVAuPsA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-Mk_VAvfsNSuAGuTx2ccWBw-1; Mon, 13 Nov 2023 13:48:49 -0500
X-MC-Unique: Mk_VAvfsNSuAGuTx2ccWBw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6755f01ca7dso9340546d6.1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 10:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699901329; x=1700506129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NngWT0kzCoGFN4QlS8k8mPScf3kiilywOIlG1/GqBxM=;
        b=ITk/4x3QGOsqjXdBJ+hFxfMpho30LLo8bUYp6vyWB3wYCp9gbYNtXCnIk8p0L/nkBD
         NYY4NjwUg5IvJA3EQ1tiHduHD/OVtZIRYdtPC+54s5CXJqCMzZXeP3fKofxBdmeM5/Yz
         sUJDLSJs1XPJajo1W5JCQJaq5tbVWcEzHAUPNu9zfAm0LhnNCIMdvu/VMkcc7rCGql3X
         aag85FjOQdID9YlvN6k+JcVQ9045Stre54o8THxK+u00g30z3csoMross1Bcz4aohZxu
         f0EH+8FC5rw6j43cCeDIxPrY5S0xeUDGhR1Gk6lrfV5AU1idjZCJXukQ/3YiYTS9zy5r
         6Rcg==
X-Gm-Message-State: AOJu0Yyrn03JsU89rwkM04JCxNgP10iwP7sDZaqccU+v2FNECiN3sy83
        jxZ3UTy8cUnMUd4WUkpF+J3lLVlvW2CFlIeCvD3EfRLgKijqZgFRntUxd6wsmtNdIZ+OQiWSXAR
        zdEo0q//toUrdtvCYAaCyTAw/4n+v
X-Received: by 2002:ad4:4f13:0:b0:675:592c:67f9 with SMTP id fb19-20020ad44f13000000b00675592c67f9mr47226qvb.5.1699901328853;
        Mon, 13 Nov 2023 10:48:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbzE1bim09XwLP9U55MdQPC6T5UtdbW6WYmAZDgK5d+4wvB9WAZ2xvAQsL95oyUSJLmbqU+w==
X-Received: by 2002:ad4:4f13:0:b0:675:592c:67f9 with SMTP id fb19-20020ad44f13000000b00675592c67f9mr47216qvb.5.1699901328559;
        Mon, 13 Nov 2023 10:48:48 -0800 (PST)
Received: from [172.31.1.12] ([70.105.251.235])
        by smtp.gmail.com with ESMTPSA id d3-20020a0cc683000000b0066d1e20455bsm2266481qvj.96.2023.11.13.10.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 10:48:48 -0800 (PST)
Message-ID: <c99d03fc-27de-41b0-bf10-087f650117a5@redhat.com>
Date:   Mon, 13 Nov 2023 13:48:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libtirpc: Add detection for new rpc_gss_sec members
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <petr.vorel@gmail.com>,
        Olga Kornievskaia <kolga@netapp.com>
References: <20231025180141.416189-1-pvorel@suse.cz>
 <900689ef-3f63-4c54-b986-f612c4b2109c@redhat.com>
 <20231113183011.GA2247997@pevik>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20231113183011.GA2247997@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/13/23 1:30 PM, Petr Vorel wrote:
> Hi Steve,
> 
> Thanks for having a look.
> 
>> Hello,
> 
>> On 10/25/23 2:01 PM, Petr Vorel wrote:
>>> From: Petr Vorel<petr.vorel@gmail.com>
> 
>>> 4b272471 started to use struct rpc_gss_sec member minor_status, which
>>> was added in new libtirpc 1.3.4. Add check for the member to prevent
>>> failure on older libtirpc headers.
> 
>>> Fixes: 4b272471 ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials")
>>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
>>> ---
>>>    aclocal/libtirpc.m4 | 4 ++++
>>>    1 file changed, 4 insertions(+)
> 
>>> diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
>>> index bddae022..dd351722 100644
>>> --- a/aclocal/libtirpc.m4
>>> +++ b/aclocal/libtirpc.m4
>>> @@ -25,6 +25,10 @@ AC_DEFUN([AC_LIBTIRPC], [
>>>                             [AC_DEFINE([HAVE_LIBTIRPC_SET_DEBUG], [1],
>>>                                        [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
>>>                             [${LIBS}])])
>>> +     AS_IF([test "$enable_gss" = "yes"],
>>> +           [AC_CHECK_MEMBER(struct rpc_gss_sec.minor_status,,
>>> +                         [AC_MSG_ERROR([Missing rpc_gss_sec.minor_status in <rpc/auth_gss.h>, update libtirpc or run with --disable-gss])],
>>> +                         [#include <rpc/auth_gss.h>])])
>>>      AC_SUBST([AM_CPPFLAGS])
>>>      AC_SUBST(LIBTIRPC)
>>> -- 2.42.0
> 
>> This does not work... since it is looking at that gssrpc/auth_gss.h
>> instead of the tirpc/rpc/auth_gss.h so the check fails
> Is it? There is no <gssrpc/auth_gss.h>. I suppose you test on some recent
> Fedora, I'll retest it.
Yes... this is both an
/usr/include/tirpc/rpc/auth_gss.h owned by krb5-devel
and
/usr/include/tirpc/rpc/auth_gss.h owned by libtirpc-devel

> 
> I tested it on openSUSE Tumbleweed, where libtirpc-devel is
> installed into /usr/include/rpc/, thus /usr/include/rpc/auth_gss.h exists.
> But on Debian (and likely on RHEL/Fedora as you noticed it) is on
> /usr/include/tirpc/rpc/auth_gss.h.
Maybe krb5-devel was not installed??

> 
> I hoped that this is handled elsewhere via -I/usr/include/tirpc.
> So, I'm really confused why would have look at <gssrpc/auth_gss.h>.
True, but I think -I only works during compilation, not configuration.

steved.

> 
> Kind regards,
> Petr
> 
>> I like the idea of having the check, but I'm not sure on
>> how to point it in the right direction.
> 
>> steved.
> 

