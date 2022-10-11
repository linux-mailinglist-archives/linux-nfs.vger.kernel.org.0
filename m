Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B6B5FB497
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJKOar (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJKOaq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 10:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3B88DC0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665498643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yYqbsnshaaj2ucwaQ/A3tH4YHSnUKNtCoZwuB3zzIaY=;
        b=QKG0SzM7yTjzytm/Oi6r7oEvur/R8ktVEK75D76btoFdBmrPVY/vTeNHePzIv6V6wFhNlW
        9+R8dEySi9unEJA8RTsWLuVXz+wsGn1vsrRGpSI6hVaSYAEy5QCZBpOduFk2tt2TSe2Huw
        YS6nwHuVNzb6UpMnYP5vFanwmxpB9yE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-ds64B9ZCNCO2sceA-OeoRQ-1; Tue, 11 Oct 2022 10:30:42 -0400
X-MC-Unique: ds64B9ZCNCO2sceA-OeoRQ-1
Received: by mail-qv1-f71.google.com with SMTP id t19-20020a056214119300b004b03f58b1abso8061298qvv.17
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 07:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:from:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yYqbsnshaaj2ucwaQ/A3tH4YHSnUKNtCoZwuB3zzIaY=;
        b=RofNFzHdLOg3m682KTNLchIgrIua4dDot/JwJoWPdeqbQNO7xKxPiCXG3vDpiRuKLj
         YxrwbCsMMOdOuAmK0vTG7Ijr4OZK8MJBpO/owgCv9REQBTovPi5tkBFbOVjIsVFb1OT4
         CGNTBRq5C4s7TEqouRdGX/PUnNAUL+k05m5uPbv2KEKZ6by4Fl6wok630uo4+vikp82n
         Tq/ckby/O7O9djmLnkuDjf0oi3ZeoCB/WTVdLlLjslOrXeuTIfl15olahIJlW5XF6L94
         wO9p7gi9n/olu/mzzykS6jPhJ1nZ6UJjMEOkip5m4ciMdZhNzCUCqi/4sKKuJuvEZB9V
         eRng==
X-Gm-Message-State: ACrzQf3N1SEiWwQb29zlFXhz7JdWzVzEG0OyfnzIRYWfAA6GA3ZFzddg
        QukeUXbs0L+LyYQPuTYPFJpYnMqWYEFPp817EY5NrUhaTFmIlSUXXBVzs831HPCm43onrxmRoPO
        yJDWLlTCxMf8Ch2M5CDdgUGtdHr3qq4TDxpuzI4ObAK9xM8swoTUGfvaQ26/tfUh3D6EGKA==
X-Received: by 2002:ac8:58d2:0:b0:398:a372:102d with SMTP id u18-20020ac858d2000000b00398a372102dmr12059213qta.666.1665498640479;
        Tue, 11 Oct 2022 07:30:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4xq6pGi5e6m2YAj/3Z6XqwtRU3LM6ac5PpCcf0SAYHBxR+mZLgzz7El8h9XsxOKJ6jzqbbtQ==
X-Received: by 2002:ac8:58d2:0:b0:398:a372:102d with SMTP id u18-20020ac858d2000000b00398a372102dmr12059168qta.666.1665498640065;
        Tue, 11 Oct 2022 07:30:40 -0700 (PDT)
Received: from [172.16.0.5] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id g4-20020ac84b64000000b0039a08c0a594sm4807307qts.82.2022.10.11.07.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:30:38 -0700 (PDT)
Message-ID: <f616db5e-c15b-0bb7-8477-dfbc4fad5bbe@redhat.com>
Date:   Tue, 11 Oct 2022 10:30:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: NFSv4 VBAT - Open for Business
Content-Language: en-US
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
From:   Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

After a rocky start, the virtual Bakeathon is now open
for business.

The local BAT test network is accessible via two
types of VPNs. Wireguard and OpenVPN. For the
simple configuration details please send email
to bakeathon-contact@googlegroups.com.

The google spread sheet [1] contains
     * Server list
     * Wireguard Peers
     * Talks at 2pm (EST) [2]
     * Client Test Results

Communication with the participants happens
on the VBAT discord server [3].

The testing network will be available 24hrs
until Fri Oct 14 12pm (EST)

Feel free to get connected!!!

steved.

[1] 
https://docs.google.com/spreadsheets/d/1Uu689KQ1LdalfsH6WYaHh8uiiI743KIeEt6MKeAVIJU/edit#gid=0
[2] https://meet.google.com/ify-afqi-wwr?authuser=0&hs=122
[3] https://discord.com/channels/720295141688082544/720295930401783880

