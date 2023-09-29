Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0E37B2FC6
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjI2KLv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjI2KLv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 06:11:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA9EC0
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 03:11:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5859b06509cso589326a12.2
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695982309; x=1696587109; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fES28ujyLqvSwqucapYKZ/aKw5qD6CDeyisPvNrsXz4=;
        b=ENJMVslSax/fhi+faNybtrmOWvqTmXHeU6xCE+tO19ZlD1QZbLePlLlDxkc3kkQEXM
         jye2i68dl/Z0YqAZkgeowqwWK/oHFuu82MSIEwl47kEY5J4A3e8bd2g2uMy3ek2AVUt2
         sWmiLxPq4NVpj2DussIRp+DbO5O6iXLe3Ao2NDPdc0SqQBIqsuhagse/qG2fhgot7DNL
         7voRLFgahFxPh6zs2nIBa4JSbMjuWl/SbXIg/2txDp2kS/Q3LiuqwIx+wPfINheFvhOt
         uXShqlkJIZ0O71Ejd5+yXrMuqxMlVG9TOqZ7JIPuMalLa5cI6HvR70/sU9qYXFAOTCgs
         NIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695982309; x=1696587109;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fES28ujyLqvSwqucapYKZ/aKw5qD6CDeyisPvNrsXz4=;
        b=SGh/4w8pI7+tu0AC7kf+0rs1WS6UosVqc1peLtegctEBLlIuVcxvTCpokE8wAU/TMN
         S9/5SQtkUCTHRMWxmEZ21pOqdG3tpTNyGwuhozmWGqtzt8WHoSNWlXFPq4l3EulP1pEP
         P373hwbQLBR3PFMl3c1ZP5YssSrilOEf/BMWX73Xwnuzn0zALpmnxdc9gHvTQYGqhShK
         PSbe/pf126LdLnWnnJSAog80Ku5YaQqFvfIblxQ9k69Ys+2lH1lnIIonKC/0N8bw66PV
         HDtGhC0rutYW8I8j//ZWs7aylRewt4u6dL954ll1+iUJ1Yj3z+pIlFSECs1bQaQ87KJc
         /OuQ==
X-Gm-Message-State: AOJu0YzPOu6q1Pa8ofoAo1ulGlAdUHhz1ZXdSOOJTUKWQLj1h/alFHZq
        EFe7EOTv2OppczTiIg07onbvMbtr7Ik=
X-Google-Smtp-Source: AGHT+IFtjOFPl5UobmK0BLI6FrU1+JwjOC1ZdROE/53BpssCEQ9Q3fh/vGJsN3n/5edwQte553UBiA==
X-Received: by 2002:a05:6a21:4983:b0:15e:9032:419a with SMTP id ax3-20020a056a21498300b0015e9032419amr3093723pzc.31.1695982308875;
        Fri, 29 Sep 2023 03:11:48 -0700 (PDT)
Received: from [192.168.169.214] ([47.15.0.160])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090a818600b00274a9f8e82asm1068353pjn.51.2023.09.29.03.11.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 03:11:48 -0700 (PDT)
Reply-To: businesssolutionsrocks23@gmail.com
From:   Akshat Mishra <akshatmishra1636@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: RE: Meeting request with
Message-ID: <b8e44fd4-5082-7763-14ec-775fbde34a23@gmail.com>
Date:   Fri, 29 Sep 2023 15:41:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi ,

Circling back on my previous email if you have a requirement for Mobile 
App OR Web App Development service.

Can we schedule a quick call for Tuesday (3rd october) or Wednesday (4th 
October)?

Please suggest a suitable time based on your availability. Please share 
your contact information to connect.

Best Regards,
Akshat Mishra

On Tuesday 22 August 2023 5:43 PM, Akshat Mishra wrote:


Hi ,

We are a Software development company creating solutions for many 
industries across all over the world.

We follow the latest development approaches and technologies to build 
web applications that meet your requirements.

Our development teams only use modern and scalable technologies to 
deliver a mobile or web application the way you mean it.

Can we have a quick call to discuss if we can be of some assistance to 
you? Please share your phone number to reach you.

Thanks & Regards,
Akshat Mishra
