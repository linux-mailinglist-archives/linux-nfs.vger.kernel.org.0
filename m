Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217E87EFDF6
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 07:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjKRGCO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 01:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKRGCO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 01:02:14 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF36E0
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 22:02:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9df8d0c2505so511889766b.0
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 22:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700287329; x=1700892129; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZ169hcoPBYCYEM8w6hjzzCiGaHW49GXo+FdoPWoHjs=;
        b=bUo12TmrhKPG3nhWrQg5kvo0eLD0B8w2ALja2fGxP6LWglEUJTD99LlhxvmaZYV70O
         pl3Pgs2Nik9pHTsGquLBb5PIm5jNzDzWElCEBW398Sd6nZYtqRRsPMrBDcvOLK9vPfcD
         Gtr1175U6Ku97zR4RY9jLMYekLooABVnamj3wCwT4F3AIVE7/ypH85wlW9x9fVb+w5su
         lArK24l6aEgInW/2o2PGb4no/ujOoyBBerwhGarCms9a/Lo0I0t6KNY0eVX5UJNrBNZS
         yMy3cW4ExdRXdsiQMGFOhdjEQB69E9XIYGByz9dWlFG8kE8avjK+yry+cW4CZESrcOrs
         u4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700287329; x=1700892129;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZ169hcoPBYCYEM8w6hjzzCiGaHW49GXo+FdoPWoHjs=;
        b=sKrh6dFVtSB5JuPZ/vIz85QPDKyQNtREUz9Oo5PZKb08CUfwvRlhbuPU8clG4HO4U4
         Fl1GlmwxOLULVKocD7KGuUhksTnyT/Xd8EUKWWYpO2vvcgHNobPOscwvfyrVOmd4x1k/
         aqHzcS0slZ4bClNUG2XmhZCLPQRTk7gaM2zRpALPy/CSytBGRiefEzJNbb3Infng4CEf
         UD+xzR9t5xFK9wBxCAv0mKa3LWjeHY8f24OtsiPufDOZBqnW9+Gf2D0h4or0zx1+w2+7
         2Ggv6MolMUBuqTWE76yxPBg5MdW5QWDEu2+sPGZK+oYG03HtySfz1VYoEsXW+roJL1g9
         Fmvw==
X-Gm-Message-State: AOJu0YwNsGkmTFO8NsQnjE6fVZXL6wlesGypDxuuLZoIWkTml1QmhkW9
        zqih+IWhgJQfhVFRuaua7BMoRtHxtAFUrVZnqgiDbMJC
X-Google-Smtp-Source: AGHT+IE+gtb3B2NL0r0qRHCQPeQT9MpdSKbKXhGZZglDyTqigY4/DxGj3P5ozF//vYF52Arg2rzbFBnfFkxmoamrcxs=
X-Received: by 2002:a17:906:f188:b0:9b2:b80d:da87 with SMTP id
 gs8-20020a170906f18800b009b2b80dda87mr6412059ejb.16.1700287328997; Fri, 17
 Nov 2023 22:02:08 -0800 (PST)
MIME-Version: 1.0
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sat, 18 Nov 2023 07:01:32 +0100
Message-ID: <CALXu0Uc7zHasg2damr4nhRZZF7xBbFc0ghdjop87+5vHa8bBHg@mail.gmail.com>
Subject: TCP_KEEPALIVE for Linux NFS client?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good morning!

Why does the Linux NFS client not use TCP_KEEPALIVE for its TCP
connections? What are the pro and cons of using that for NFS TCP
connections?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
