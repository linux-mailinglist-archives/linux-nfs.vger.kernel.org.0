Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A19777C5C6
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 04:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjHOCUh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjHOCUc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 22:20:32 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB1AA2;
        Mon, 14 Aug 2023 19:20:31 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9cf1997c4so4216009a34.3;
        Mon, 14 Aug 2023 19:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692066030; x=1692670830;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vBa0k7wLAl4LDRhr7Q0SK1U0Lzz017ulFjWcOV2uR5Q=;
        b=T2p942Nx3b6BENCac13cMNM161q1AnVi2c1qk3HetHA7SmQs4zP6yzcvzzjUR2/OUT
         USz2BO+NbMw1NR091SY8jjpTGa2/QRGgS8SZghuS4l+U9fn8YAgFuk9iaBUmB9OnpVlf
         cqbWJWJKYocmd0N5DosiMQNE4bAF3wh6WM3nOhN5MFBIwkiDzWUYApnczWePRpEhsHV0
         GdAKPMFt0F6MPEJN1yBZm69E12uLoc4kqt7uVXBtgk+mUK/KyDNq0s+alOfkeu/FJ+9A
         KVR/Rt75LWTp96Gp6fNpOvmRIbhfgfTsdrTSvi42yeHUtjnWkRvdxEGBJ6DSLciz/Uc9
         cvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692066030; x=1692670830;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBa0k7wLAl4LDRhr7Q0SK1U0Lzz017ulFjWcOV2uR5Q=;
        b=en8pmpvpEq3MLokdJ7cBpOO2PHQYdBrIuvcyKj1gMgBCiLHelWKOYbrs/ldSqAQjuO
         uXz+Hnzuj068Hubs6rSe7LZbSudOkAeTi03XQKv3sVDpeNw0Ruw1vHcdJBTiUl2Owqoe
         1lbbmjB+EQ3q3B5Q06sJDoap3J7LVsbiW/LYJCWSBfdYWpMf9/Oa+nFslio0KZASWLGz
         oYJuz/bIoGXExklSSosMq5QEYovFDxpoDiJYBBg3BvSKQ18KWt2Elp0b25JFgdIEcqRk
         Vt8zS5c/NO5o05U52MYkqMf3tZtHORe2OHaNo0rjKHDUivYeNl8HU3B2GNtLKio3CwOP
         xiew==
X-Gm-Message-State: AOJu0YxEIFOGxY+MV94Sdpxt6gS1jwzHzK43O3osciY2dIqS7CAxbHv1
        /Q72rmmPN1tOh43V714QJ5w=
X-Google-Smtp-Source: AGHT+IFe7jcVXkmYjmtknd1d6TrdK17IZhH4VXy2e21Sc9ZQKcG+7CyLZ9I/OBOLWQBovHllx1a1Qg==
X-Received: by 2002:a05:6830:1502:b0:6b9:68fb:5b73 with SMTP id k2-20020a056830150200b006b968fb5b73mr10074394otp.1.1692066030382;
        Mon, 14 Aug 2023 19:20:30 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id j18-20020a9d7d92000000b006b9c87b7035sm4858164otn.18.2023.08.14.19.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 19:20:29 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <89db6c13-60ba-b54d-c8ff-0a0b1d6e49cc@lwfinger.net>
Date:   Mon, 14 Aug 2023 21:20:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Memory leak in nfs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I am writing to you to request that the patch by Benjamin published at 
https://lore.kernel.org/linux-nfs/54144a14-606a-4f2c-ca19-9b762e1f7e91@linux-m68k.org/T/ 
be merged into kernel 6.5. Because of this bug, a block of memory is leaked for 
every NFS mount. The patch solves the issue on my system.

Thanks,

Larry
