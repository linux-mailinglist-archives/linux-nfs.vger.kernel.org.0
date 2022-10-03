Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5DF5F353C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJCSFz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 14:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJCSFi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 14:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458B2982D
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664820323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BYNssHAqVtJ+qHm3TKqvHEUmc+owlGGT6oMNyTQmdhY=;
        b=ZWIdeENYJ3S8RaX47TEHQpu+/rLORSB+usXsyCp9fSG5iUdG0IckTYTFxKWAWQuCH8M6x4
        sR79Z2nYiIpsdK50P16NsH9GsoUcqLdSTE4eEpulyPqzUq4l//KjQumzC4P95HOuc0Cnkz
        uWmECkDBzg/QDRWpSIzRSJNwLCneWlw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-_LEgQzpkNqaPBQVMFdJz8g-1; Mon, 03 Oct 2022 14:05:22 -0400
X-MC-Unique: _LEgQzpkNqaPBQVMFdJz8g-1
Received: by mail-qk1-f199.google.com with SMTP id az15-20020a05620a170f00b006cece4cd0beso9761085qkb.22
        for <linux-nfs@vger.kernel.org>; Mon, 03 Oct 2022 11:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=BYNssHAqVtJ+qHm3TKqvHEUmc+owlGGT6oMNyTQmdhY=;
        b=1fJZbfG7nTB44CfnLFnNWdKQxnqSrueqJv24ugOV6B9vgvDLJHdf2RHjrdlUjKj4ca
         P/w4FInNVQiEL6ViCozz03/I8Ut8VvafXIdqq8XeWuPbJgFesXRVW/QGfANgahxGQbTk
         AQAa3bEJKnntWq11RObJmYyTaigaBjaJ0a/B4xu94OYZ71wrW9wSKbxNc08G8p2cAzGZ
         YHCAtw+0ReLdTTHqPeawhfby2uMxtz3Zj1v6TJs3TkkhAZX2cff452ayd4o1ufhYTP8w
         l0d+7rei54nk1mnwoucvRZ1acLUpV1qQaqMCElGi8zd+1sMMzdlqwLn5IlPX6n3EEJ3W
         eQCg==
X-Gm-Message-State: ACrzQf3aMqFim7/HnmikQs6/EZqNWAnzFKimwVEteQIiiZPKHoFFvf3Z
        Q5/INFt3ej3n3MSuTRbMMRehoNLyRqI/3r7m2fqKZN4Y27oPyDYHnoLMV0TDO+IgIVhIQNhag1U
        C+8o9JHOTaLndPPRAsMy9u7MWs9mWPXxdprSE6VnOfde1qGHAIUCNVLDKHfNKrPfffo6/Zw==
X-Received: by 2002:a05:6214:d0b:b0:4ac:873b:ef73 with SMTP id 11-20020a0562140d0b00b004ac873bef73mr17251332qvh.82.1664820321499;
        Mon, 03 Oct 2022 11:05:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Yv485DkMxaBLYA8rhsqWy2jxrIWES4+URx2Mq3YS8tI6PmQvqCJ893q3bBb38Smfdp6hCwA==
X-Received: by 2002:a05:6214:d0b:b0:4ac:873b:ef73 with SMTP id 11-20020a0562140d0b00b004ac873bef73mr17251308qvh.82.1664820321162;
        Mon, 03 Oct 2022 11:05:21 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.137.95])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a454700b006b640efe6dasm12023032qkp.132.2022.10.03.11.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 11:05:19 -0700 (PDT)
Message-ID: <c15eeb0c-60be-fcdb-b464-a8f98553baec@redhat.com>
Date:   Mon, 3 Oct 2022 14:05:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
Subject: Bakeaton: Reminder... One week away.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

We are one week out before the start
of the fall bakeathon at the Red Hat
Westford office. *Mon Oct 10 to Fri Oct 14*
The details are here [1].

We also have virtual access to the BAT testing
network using a WireGuard VPN. To get that
set up please contact: bakeathon-contact@googlegroups.com

We will also be trying having talks every day at 2pm EST.
The sign up sheet is here [2]. If you are interested in
some topic please let us know. These talks are open to
everyone, whether you are testing or not.

I hope to see you... one way or the other!

steved.

[1] http://www.nfsv4bat.org/Events/2022/Oct/BAT/index.html
[2] 
https://docs.google.com/spreadsheets/d/1Uu689KQ1LdalfsH6WYaHh8uiiI743KIeEt6MKeAVIJU/edit#gid=1920779269



