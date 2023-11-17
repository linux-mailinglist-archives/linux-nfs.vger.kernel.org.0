Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15F47EF79F
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 19:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjKQS6b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 13:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQS6a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 13:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E752E6
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 10:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700247506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AQKHlXidiDt+M3MxLcZzVRnRIoQZQv44Ty67kKbq6WQ=;
        b=Rrx18G+Po+8PBkBE/msBgUxjNXcSsP1J938QIT0I59Tth076onObhA+PHevBLiz40V+zM9
        shvoYJBfqhtqvKiwHGBGb2QuNkxa8qxheMi18Kaazpt1JZ66I9gJVGJjpYq5kkOM1ONmJ0
        tc8TFAFrdUX7WHBrL/7rDEW+x8zOw4M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-iigrupUmOhCTiyrOWkCNHw-1; Fri, 17 Nov 2023 13:58:24 -0500
X-MC-Unique: iigrupUmOhCTiyrOWkCNHw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6754babc2c8so6699006d6.0
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 10:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247504; x=1700852304;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQKHlXidiDt+M3MxLcZzVRnRIoQZQv44Ty67kKbq6WQ=;
        b=YWkTikiWpLJpi+QjIF4a1bA4/g/vyI5AX2E91SfAiK7d7zGDyJBgO83uVX7hAdBIpZ
         DbZoZBFCrRIlTWvB76sMrA2X8ByWBcYQgysun/uBqpggrhwD00+oiw4QPtkA1SUuTm4t
         O3X4jDfMz/p38yk+se+I9w/yFRNJak7w1v9jVdzwJg14vyPid1cOyxZw9hxTgJoxmfwc
         dx5qqKvHUZmHNdsGdnepZrK0IU++4y5e4VEXkjTG1EerPFMhlxJ9sj5fu38d6rRuSC8x
         +p/E/9RqCvQkaSDXcSZztWUEoTbOfVeuGWP9bnq/bPHvc5vV1qKEjz6HF612byaGSJzs
         /wJw==
X-Gm-Message-State: AOJu0Yyr/hXZmOJslGofQjLPVoVrzbbhQxWShsebCnklzImEbNLrWafL
        zMyZkG6IWImV7gl+T4TC2R5bA/i7s1IMhpw7kBdn0cDnHbyizxFVsAecHTrLUidnvUQLIqRBJDr
        4Z4ts7zqggVtvZ4HmkM+uDUAeQq517nya8RQvoYZme3WKsj7RNZvikmjxulMpqVe7WeZ2OiBtxI
        B/XA==
X-Received: by 2002:ad4:5ba6:0:b0:66d:1012:c16a with SMTP id 6-20020ad45ba6000000b0066d1012c16amr13083905qvq.1.1700247503899;
        Fri, 17 Nov 2023 10:58:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHckEqremfB/8sydMVrOBFf/+LIb067OixiZVjVDuDKvH+dYSEUbT6n8vtpqL4tn+1ktCwT8w==
X-Received: by 2002:ad4:5ba6:0:b0:66d:1012:c16a with SMTP id 6-20020ad45ba6000000b0066d1012c16amr13083892qvq.1.1700247503572;
        Fri, 17 Nov 2023 10:58:23 -0800 (PST)
Received: from [172.31.1.12] ([70.109.136.127])
        by smtp.gmail.com with ESMTPSA id o1-20020a056214180100b00656e2464719sm840783qvw.92.2023.11.17.10.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 10:58:23 -0800 (PST)
Message-ID: <a870ef0f-99be-43e3-9596-8b28938fd48f@redhat.com>
Date:   Fri, 17 Nov 2023 13:58:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.6.4 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

A fairly minor release... A number of bug fixes in
mountd, export and gssd. A regression in the Junction
code was also fixed as well as a few systemd and doc
fixes.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.4/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.4

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.4/2.6.4-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.4/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

