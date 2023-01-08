Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B6E661A52
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 23:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjAHWFb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 17:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjAHWFa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 17:05:30 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67EDDFB6
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 14:05:29 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id tz12so15836902ejc.9
        for <linux-nfs@vger.kernel.org>; Sun, 08 Jan 2023 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=btexyd508eSAft3Kf14Tjibkj8JPvQcKIrtIwmp2ltwmcIZEG+K1JW8+HvnCPTL6Un
         f7npHQsmouX9kDLZNLycZ+Ekq2RsSeqsoFOkCVZgGemmKglBLaVAg+8UPK5Ck20okFgM
         p019o/mwPEF2qhqsxEoQiyKzOUG03dQPP94l5owQ4xucijw6RqUx1OvN3jMxASAM9KDc
         VhBps3I6DjNlWyFbT6Comh+kcpmz7eQdJPeSSp8qD694tw/2YTZasboxSabrrms/vnoZ
         9e/pBilq33C6ccWiXu74E8RakO+US1t3jPuye/IHi4OWzhDsMi5VHDQnUA66S5877VvN
         MjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=3b9SxVUytdNdIkzrlnNsY78a2l10VPgUtN0d9GJAaNB5J2XOev3JODvT6g+/W/jPTy
         e1CoC5i1dC5YAJ37nRbv4WR6gofnuzILVwQ1+wyLbQDTwm/EJwnsoh1d6rG7q/21xoEY
         xZWc2kHiGi18IkMGDxa+aA6kFWzjM/ABcJZIphT0qMKQa/goC4jAuNo9zf6MX62/7+6d
         pxypdpw8YjQ0aZAfJyo7evFAFnDwWmhtR4JKmA+M9zTxSPTfWADpGHXpgEGFtnkdegFN
         /V3uijrVMYCFk+1SQdbT19RMAdXz8I2nB9LtvcD8e/f+DKOiHgvuik1ZLApI6rebMsOA
         kDQA==
X-Gm-Message-State: AFqh2kpbhI/7rVyQg0n5gbMHut2Tls1ScVgZcPYVbocqwZpQBVZNpVCo
        c8fEYb0n5WsA/m/l8DFX84dczdNypQxRofT+CdI=
X-Google-Smtp-Source: AMrXdXuHS3oc+JriIdyy0XeiLRp8OOUqhbVdbT/9leOHfddAjuXqdAlhXSZRvMNdlDxDOaxyiH5sYvW10L7vW/6sTAg=
X-Received: by 2002:a17:906:b04a:b0:84d:ac8:ec37 with SMTP id
 bj10-20020a170906b04a00b0084d0ac8ec37mr1054614ejb.138.1673215528000; Sun, 08
 Jan 2023 14:05:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:31d3:b0:60:a1eb:29c5 with HTTP; Sun, 8 Jan 2023
 14:05:27 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <tracymedicinemed004@gmail.com>
Date:   Sun, 8 Jan 2023 23:05:27 +0100
Message-ID: <CAAqZ+HCiuhA6sFXfomcfjPfJSXhQmrk+tuCbA3eUmSVgdObXzw@mail.gmail.com>
Subject: From Dr Ava Smith in United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- 
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava
