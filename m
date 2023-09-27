Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7D37B00C5
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 11:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI0JmH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 05:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjI0JmE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 05:42:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7CC1AC
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 02:41:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so12452802a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695807717; x=1696412517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8qccYZq3nXWq7KnAq4nyauVsORB4qrbT0AJ4HVX8fA=;
        b=dPRNnkKkIhyhhYKM42wdiiXgd2ddzLNnYlIx7xFhg8kg+HdOqZbti0ERweI8SWs4eb
         Cus7+iGzZSExFmFFoeZqveq0U0XIm74MAHJfoiIY/uuFH+CvrQPweTYBIU2hfppsHRJx
         7z/bvADfrfvmCEKEf5wrxfE5pWS/NOldWUDedhHwHhsNd6negJFAH8CgT5QE1Wces6u+
         vwSxlIX7nVi8DNIZOfURWd1659VjcnTrHCaT0SSRM+enIeDof/OGycDlgjpd8DKt0dP/
         hnVkm9sThEhGLBxl45TTWW3pY3yJafjogBoaxKKuGHZmuP16rq8qg/XJuDvtSo1vPu1W
         kcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695807717; x=1696412517;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8qccYZq3nXWq7KnAq4nyauVsORB4qrbT0AJ4HVX8fA=;
        b=fQVQ6N8mQbcv8n4l8fObOrXwb2Iw7c/OL4HnLF3oKaCy/ZpszPvkgihM6zLPMCbcXc
         AFYl0Rw321bZyJQp4ZeJawnjLItWYpg6CYr7dhyx25sWbNqS/Xayw1mKziCzlXrPCvtd
         bpytLg0RARlhlE28h379TDLHjX/0GT+6nCSlbjw2MfV7uHNVVTxflZQ+MmJk7SY42WLZ
         VaMdv9XaXJn1yL3P3E859T2UUc//A5pIoS+9SZ9GtmpBt50qh48X3cARpr/ChYdxCtsR
         Dt9lhZlJRoRoNFMeidUiSuNuadX1nzUirY6N77l+iQrgw89pJqqD5sdpqSJXBWwkoCOL
         Y4uA==
X-Gm-Message-State: AOJu0YwIELyIzPkCaDFIpobZbw/fq660EoFE2uOILoi8ys2p+v8Ngi9Q
        zhrrilSzMLA5HpqxBl8cs1qEYMNzGew=
X-Google-Smtp-Source: AGHT+IFcFFSJ8JVUkzKhEWMcL2vTXccTVOrDwOvsJbV9djEEZ36GkIPYIWwr3R/RJkkPJPfxQpn5UQ==
X-Received: by 2002:a50:ee0b:0:b0:52e:86b3:a4a6 with SMTP id g11-20020a50ee0b000000b0052e86b3a4a6mr1416657eds.29.1695807716760;
        Wed, 27 Sep 2023 02:41:56 -0700 (PDT)
Received: from ?IPV6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? ([2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id w25-20020aa7d299000000b005329f1aa071sm7849966edq.10.2023.09.27.02.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:41:55 -0700 (PDT)
Message-ID: <6f927572-5296-47ec-ac8b-d12cabd2c566@gmail.com>
Date:   Wed, 27 Sep 2023 12:41:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Content-Language: en-US, lt-LT
From:   =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
 <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
 <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com>
 <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
 <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com>
 <CA1D7203-72FB-4681-AD60-F1D80A57C154@oracle.com>
 <8cb19861-7fd2-4d12-bd76-78bbb8fcee7c@gmail.com>
 <2660F09A-5823-4581-8977-4F41153724D6@oracle.com>
 <5048a7a0-d2fe-41f3-be3b-4eead930c414@gmail.com>
In-Reply-To: <5048a7a0-d2fe-41f3-be3b-4eead930c414@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 27/09/2023 11.45, Mantas Mikulėnas wrote:
> On 26/09/2023 16.57, Chuck Lever III wrote:
>> I'm wondering if I can get you to bisect the server kernel using
>> your v5.10 client to test? good = v6.4, bad = v6.5 should do it.
>>> Yeah, I will try to bisect but it'll probably take a day or two.
>
> I'm *nearly* done with bisect (most of the builds with distro config 
> took over an hour on this aging Xeon), and I'm currently in the middle 
> of:

Now it's done with:

703d7521555504b3a316b105b4806d641b7ebc76 is the first bad commit
commit 703d7521555504b3a316b105b4806d641b7ebc76
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Thu May 18 13:46:03 2023 -0400

     NFSD: Hoist rq_vec preparation into nfsd_read() [step two]

