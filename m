Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505715224BB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 21:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbiEJT1P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243412AbiEJT1J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 15:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A7852A71C
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652210817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zc2VqKP3bYDniXxOB3i3TXNdHGGkZK9PgvgrEZQCguo=;
        b=PSJ8DCO/7k9kRLL/ZZGglZZopnK8146F6QbqsWe87xNHmBx0lkSfQFQvTmVPl8GpBEgeC8
        XfkEEmMPJdcmuMccFiKOm7ltxpx2XMfGioCdBAlQh6LmhNzkUf+C4NE/7b3CeyOZRacahO
        hzF/Rqw9CGgPIZxnPPusyo2swFIWsXU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-QqrvaKkVMwOF4w3ZPUGOMA-1; Tue, 10 May 2022 15:26:56 -0400
X-MC-Unique: QqrvaKkVMwOF4w3ZPUGOMA-1
Received: by mail-qt1-f200.google.com with SMTP id i11-20020ac85e4b000000b002f3d8c3a96dso6106506qtx.9
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 12:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zc2VqKP3bYDniXxOB3i3TXNdHGGkZK9PgvgrEZQCguo=;
        b=tq/GlVY4p+iYIqAiFKyaCCG6+Xel6EmfTQ6wfJWxXFcCr8rVuu5/TiBjmYoWQwqM4j
         TASpLdpXtwqMFbJzx+LAVaxrsfPVSosfq9TLXiBtXRI1Ab2OKtwAbMz+2zydT3g9GVZ0
         8rqZOMhbaKN5mFDwRYC3J3KIFM2kfsOkgHuVcyohyPAUOddrK62iLdMPvttiDf8uVW0T
         pvNTvPL36b3woHltUDst+a/c/kFcBOWerpI2EfXQaCwT/ZqJ3Ovt4Oco2oAO+7JLwfXu
         soF4cESJQhqoGYQczYgkKy2RGZtuzpQEXWanTqCSv9tPuYs+qeHHekCbE9r6WURiClj/
         lT9Q==
X-Gm-Message-State: AOAM532cFsoGBToJDDaso7FXxYBwvYXZtGwSGj0d40WYp+O5fkYMtCut
        B46IVxWjBZtBeo70KC1uZ37DH6rCLQHV++YCYDkHFrd6p1peEE3Oy++jdcR0GmMM7XlZUYVWFb2
        KhX2qb1xPXOBHgp2ap83q
X-Received: by 2002:ac8:578d:0:b0:2f3:e61d:df9e with SMTP id v13-20020ac8578d000000b002f3e61ddf9emr3729733qta.181.1652210815531;
        Tue, 10 May 2022 12:26:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdqwC9j0cIDtqmP4VXIOnW/BledmnofOQDwcQzhc9ronmybm2PaKl1K0LUM0KtFRuA15EAog==
X-Received: by 2002:ac8:578d:0:b0:2f3:e61d:df9e with SMTP id v13-20020ac8578d000000b002f3e61ddf9emr3729712qta.181.1652210815282;
        Tue, 10 May 2022 12:26:55 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.92.61])
        by smtp.gmail.com with ESMTPSA id r12-20020ac867cc000000b002f39b99f6b7sm9717702qtp.81.2022.05.10.12.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 12:26:54 -0700 (PDT)
Message-ID: <f49a19c4-813e-4d88-a99e-aedcb1c0d821@redhat.com>
Date:   Tue, 10 May 2022 15:26:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] exports: Implement new export option reexport=
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        bfields <bfields@fieldses.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
References: <20220502085045.13038-1-richard@nod.at>
 <20220502085045.13038-3-richard@nod.at>
 <200443c8-c53a-a7ff-0876-aff144963267@redhat.com>
 <1306432546.48658.1652198772007.JavaMail.zimbra@nod.at>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <1306432546.48658.1652198772007.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/10/22 12:06 PM, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Steve Dickson" <steved@redhat.com>
>> A compile error...
>> reexport.c: In function ‘reexpdb_apply_reexport_settings’:
>> reexport.c:335:25: error: label ‘out’ used but not defined
>>    335 |                         goto out;
>>        |                         ^~~~
>>
>>
>>> +		}
>>> +	}
>>> +
>>> +	if (ep->e_fsid) {
>>> +		if (ep->e_fsid != fsidnum) {
>>> +			xlog(L_ERROR, "%s:%i: Selected 'reexport=' mode requires configured
>>> numerical 'fsid=' to agree with reexport db entry",
>>> +			     flname, flline);
>>> +			ret = -1;
>>> +		}
>>> +	} else {
>>> +		ep->e_fsid = fsidnum;
>>> +	}
>> I'm assuming this is where the out needs to be
>>
>> out:
> 
> Patch 3/5 adds the label.
> Looks like I messed up something while reordering patches. ;-\
NP... there were a couple linking errors that also fixed in patch
3... I figured it out.

> 
> Do you want me to resend the patch series immediately or shall I want for further comments?
No... I have the on a branch and at least the compile... cleanly...
Now on to testing! :-)

steved.

> 
> Thanks,
> //richard
> 

