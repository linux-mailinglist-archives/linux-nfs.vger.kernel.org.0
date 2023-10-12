Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D5C7C73BE
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbjJLRL5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjJLRL4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 13:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE88C0
        for <linux-nfs@vger.kernel.org>; Thu, 12 Oct 2023 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697130671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xYgBB6rpK/aH7faCeOU38sUrphHtHsYV8i45RUc73DI=;
        b=WQdMPpliUURBtQHsnFANwNphVdgmKY16rWrzmyfH4hi6g2dLBCMv9hg+teBmIaVtUW1tqc
        Q7J48xO/2hUWpYALGfIZl/f+Fs7QT5uSAIxOBz/H32BmIMzCqS5hUu0iNCdaJkIfito+nm
        zL84ozWx/35xoeognOx+wzE5V5fryUI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-y04e38sPNySEVLgZr3ZglQ-1; Thu, 12 Oct 2023 13:10:54 -0400
X-MC-Unique: y04e38sPNySEVLgZr3ZglQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-457a8fc8a31so135877137.1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Oct 2023 10:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130649; x=1697735449;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYgBB6rpK/aH7faCeOU38sUrphHtHsYV8i45RUc73DI=;
        b=gLCZdcycWJPEz3w6sVRvZJjCMsY+JHMnXC15j32v4ifNe1f+nXG0Ov0YXIA8gPQmvC
         yXWZPsJNJkLBn5+MuRDR7WBmzGjFalRouCci1lE/GMRPjK6jZaXFGM2IWRmQmgr8R1cz
         wbm+GFoUGOAFqq1jV0OOwG40y4HMdqOZjM2dlY4t1M2xZeohDyBEIA4O+IktNXbvaTPk
         NcO6NOuZU9+MVt9T7urY0iBqCW/u3r1JHTKHpiTNksl1IZhQbsxdq5dw68EjwNArpc63
         +7lC9tIkAzyeCmNk5nlGEFDEBgo7EA9suY8Oe3xqUlDtdnelyL3tT3LWE0mQbNP9Vpf9
         2Yag==
X-Gm-Message-State: AOJu0Yx5jJBfijNheYv79W3vqRDtH5TvBTRC0RXU1bSBmKHC8XmzwgW/
        AxN6rBkikuSPUX14JVkOSLHGDi3NKBjEzFt+jcQU5C5YaZ+0jFuYUaFaEklDFk4EsKQeLbkarha
        XXS8+gOlMs7Bn5uTEo6nQ+M4yGIA4E12/Ln2WMaE9L7ICmzTZsQhjMHSei0q+D2ykZaz/VY1roW
        Kazw==
X-Received: by 2002:a1f:6e8c:0:b0:493:69f1:d12d with SMTP id j134-20020a1f6e8c000000b0049369f1d12dmr14380449vkc.1.1697130649123;
        Thu, 12 Oct 2023 10:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5FRRpt5enqiG6+oF77YqtYdrxCKLFGVuWs4PaA9t1ubZTltCdyKiuJPd+X/2e6F8osK6kfg==
X-Received: by 2002:a1f:6e8c:0:b0:493:69f1:d12d with SMTP id j134-20020a1f6e8c000000b0049369f1d12dmr14380413vkc.1.1697130648626;
        Thu, 12 Oct 2023 10:10:48 -0700 (PDT)
Received: from [172.16.1.21] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id q5-20020ac84505000000b0041b0a7d1872sm5378478qtn.70.2023.10.12.10.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 10:10:48 -0700 (PDT)
Message-ID: <6fff3489-d807-45fc-aed2-e0813dae39eb@redhat.com>
Date:   Thu, 12 Oct 2023 13:10:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Steve Dickson <steved@redhat.com>
Subject: Bakeathon 2pm EST talks
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
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

The Bakeathon talks are starting Today, at 2PM EST

The topic being: Client multipath (and background on NFS in VAST Data)

Feel free to join us via google meet at

https://meet.google.com/gyu-kmxt-rke

steved.

