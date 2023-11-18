Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658997EFE6E
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 09:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjKRIDe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 03:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjKRIDe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 03:03:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80DAD5D
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 00:03:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so3771899a12.3
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 00:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700294606; x=1700899406; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z/nt/9jUiLAnhF84ScB9MoWdM/gtc7wIhaLDY+1VRlQ=;
        b=hVsc5hGZo4sorbU37X7OEF8wqtO3olD2+4B6noP8bndueB1FZ9tu/QpdoEY56R2M/W
         hp1O/9w8aSwQcYtrxcy1i4/52SB3Lq9Jzue9KqHspbbx8op8Pjrw9nch7O79l4gqfFj9
         Smrdjt7OeUqA6uCgi9JbkC3TXerzS9B0Q9CQ45I5ZizFh3+WrsAUKybkENcOwIfGNPF+
         Y6VncW0UEu+JnNCY+coR7+dCA0d695eu8HDl1OxA0ZdPJxfn6gqEki2pLleZSEuRl+uL
         Y4FD0BY8zmC5ka791/wTeCh5YBmI2SU9/qc4vjExwpPqKgA/MHX7uwADJ2602Pv+74ST
         woWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700294606; x=1700899406;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/nt/9jUiLAnhF84ScB9MoWdM/gtc7wIhaLDY+1VRlQ=;
        b=htqI9GLT66YdPXJ6RX+fdqJv68NEAloNJ4VdRmkKvvVvHaF74ixCCNFq0zGzxXH868
         1K9zy3URMfk+Xgz5xCGzOaYn5HgaMbGdJCXkGBoNg/pxnMkZbyxlnA8Am1a3NXNmAAqI
         /AU+oamQa6/66aJEhXyFqGyAmjKTublF2j8IkZaqDmOyiBRZZyl6k74l8cop2xy7HdOy
         f7SHmZAsl2N2VMINAoLjLbWWK2LrORqpj1EnTPlMRhDv5ZWugb82NhY9vI+iSW4x2IP0
         8kOD8q14pBbCvWsIHoWOFOXFaL35hsiL4lyU5b4yKo9aqx+2S9Nc79UibcwGhp3VGVYL
         8q9w==
X-Gm-Message-State: AOJu0YxJmWSOUDMqSVN/CdNhWfZzzMKYf28N5DbHC8+9QAjNuE+YeRWg
        DI6J47xWq1oVnlCB99Pofk80FLMTWcefxQqYlp63rVZ2
X-Google-Smtp-Source: AGHT+IEBwo+6uO7jlBrfUfMHcZzXfYeTiev7MQFNnJiw0Ef0FuOvT2+DnzYMqzHPap6D72pWsOZvSzHupsEw63JC09M=
X-Received: by 2002:a05:6402:1612:b0:53f:1067:4b94 with SMTP id
 f18-20020a056402161200b0053f10674b94mr985861edv.18.1700294606583; Sat, 18 Nov
 2023 00:03:26 -0800 (PST)
MIME-Version: 1.0
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sat, 18 Nov 2023 09:02:50 +0100
Message-ID: <CALXu0UfhH7AQ=sqDkGAukYPDN-HYGkwfsLuswkmYeDRgcgJ1XA@mail.gmail.com>
Subject: NFSv4-over-TLS, info?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good morning!

Where can we get more information about NFSv4-over-TLS? How will it be
implemented? In libtirpc?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
