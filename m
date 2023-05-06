Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFB6F8EAE
	for <lists+linux-nfs@lfdr.de>; Sat,  6 May 2023 07:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEFFSx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 May 2023 01:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEFFSw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 6 May 2023 01:18:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04CD76A8
        for <linux-nfs@vger.kernel.org>; Fri,  5 May 2023 22:18:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-250175762b8so2035302a91.1
        for <linux-nfs@vger.kernel.org>; Fri, 05 May 2023 22:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683350331; x=1685942331;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIyV8ZdvnkK/lyp+UsCdIX16AiWp1+i8r2XLRtim6U8=;
        b=noh4phQMvR2sFNKTENHZF0p0wonSQtcBBnsmxfh70UsNisNvue/tm3EK8r5zzEbZmK
         EPva8TVeyQiNqgnZY1FPBXij/6kH25yNNUeFFoNgAGy0IPYL61wRAbji6haU8BT7MeTN
         SA21Nqzsx7Xm2SnS2sI5aLySmVjcN0/A18Sxw4PdqK0+NKAOU79sh5OP9dK8z3mUCTuV
         NrhxpGtxe8sPoYnNf9oG3hHqP8sZAHFWLlgp4GnUq6/QAllEHE5vPCS/E7VeeJGqCj2P
         sTjIT7UYE0/P+m9j1ruL4zLGZQmOKSGfI/D8aoz3r4h3oSbUyYPx0gWRH+kjq9w9ityD
         SgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683350331; x=1685942331;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIyV8ZdvnkK/lyp+UsCdIX16AiWp1+i8r2XLRtim6U8=;
        b=hQhHRgdPx5ysGWbBfI1uX7Mj0G+JgplwuhNVG4x61pQzRwCnZsnSvjD/MEMFZ7ALU3
         22fXU+9hNE5BBYLkUHLRMua6/of1VDf/KcKgSKklC0xuVLp7EYRm97hUZMRNFgYrzDLf
         NleWEhW/VnZnYkM4LQShHmAJlwRCBf3gehQurGa2s11JI/C3uBrhxTxFyriN7yawXxTU
         3Y6OzD0InwSKw65oCaU0tHoVdvDbLtagLGzDAAglOJwj9AVPfJYL2jd2dhpBqpSlwGdN
         Y8cnXJmwSn1d+yPRhWW/IUhUdFBNCgnkncimzPeuTJfRzWd/k/2xBKydCWF+E3l0bjSp
         3ExA==
X-Gm-Message-State: AC+VfDwQ164f0qWh4jQkrGtS905p4H7ixR//CpIE9X4swn9p5BPicrY5
        oLTezscxV6bSjEiRDdv+iuzgEEFFLSc=
X-Google-Smtp-Source: ACHHUZ5hAzmYw/ZBH7mOtH+IOWs8FKZXkKEXZ0RDvZf3UcsJc4FO0BUH1oSOoOWDXfupwNhOOvXGKA==
X-Received: by 2002:a17:90b:1d86:b0:250:551b:773c with SMTP id pf6-20020a17090b1d8600b00250551b773cmr46166pjb.3.1683350330831;
        Fri, 05 May 2023 22:18:50 -0700 (PDT)
Received: from localhost ([103.87.58.50])
        by smtp.gmail.com with ESMTPSA id fy17-20020a17090b021100b0024e208a6464sm5876726pjb.15.2023.05.05.22.18.49
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2023 22:18:50 -0700 (PDT)
Date:   Sat, 6 May 2023 10:48:46 +0530 (GMT+05:30)
From:   jlalit0225@gmail.com
To:     linux-nfs@vger.kernel.org
Message-ID: <148347401.42.1683350326255@localhost>
Subject: This decade has shown research firms...
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Salutations. Businesses have shown us that the lines between technology goals and business goals no longer exist. The near-term impact of this is nothing compared to the long-term plans of each organization.
