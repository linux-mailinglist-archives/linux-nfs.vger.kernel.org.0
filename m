Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55A7EDBC5
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 08:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjKPHGH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 02:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjKPHGG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 02:06:06 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7484192
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 23:06:02 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2e73a17a0so277130b6e.3
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 23:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700118361; x=1700723161; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8aivEN1MitybUXKlCorcU36zhx7TQARtWZEmZVSlB0=;
        b=imjf3AEykGA00zOwtXXamrdkON/lzZLyQbUm9x5jX0mNYASoCYsz9wWyJSB0G8tETd
         WDQYhZY+TPvH1vs95+5pX0FMDKBFand+tqGol1lGQwv4NwIAWzwuZs8zBKxv/yuEhN4k
         4Zpllt6or3LRETXLqcjdkhuQrlFImq1peXdzo04NlAMm1Fg5Mb+e4NS+2FTaEz4KaY03
         /x7L0x4wOZMKzogg+pZCn4fH4mPSN1NXx8pakn7SYPXlcajOdksAVfSsRV79kWMjOJ6Q
         NQ14tAW7TtDSMWrSeN5xO5Zym5YlT0dkTYl+CesPxBRktAXI3r3yYJKeUcoZ5cLZdGIT
         sYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700118361; x=1700723161;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8aivEN1MitybUXKlCorcU36zhx7TQARtWZEmZVSlB0=;
        b=WzYCCEgzzwgLb86xSpUWHaC5eOQe/dELdzbeQ1xY71sbi3WSIL+QIHZhmp3CI70M4u
         vL09x+2m0yB1IohLIb3z99ZJ6yv4PGTeCIVUmeMd+S0yahpY5HXdKETkyy6VR+K/Przj
         gFSTNeA2T+F/qL7dNso0ivCqzhvo7F74/yasqTYVrREfLdiNeDZ8V4lsJY1YbUci/miV
         G+3M1Ll1HwtzXwEyhPE/n2H2pKvo8/926gwAfB6iYbw3sQ26EOwPNpRoE1GPwxBOjZGi
         nlasVlHf9j/1GcMF7SIQSaIT+oPW8HME7DEfvN75nZGvkI7KvRnJv1xM/D9A/pWKChHL
         y4Aw==
X-Gm-Message-State: AOJu0YyT7AcrQhIevrWgqgXgqOUNNSEENClPLkcWlHAAbAwxW+xb8sIT
        dNg5mwhWgJL9e8fooqTP8lXtL1Lq7FeWGxPy0oo7BDVV
X-Google-Smtp-Source: AGHT+IFe8Ywi3wQu9UXrKtq6TmrV4kTVu6pYNhE+00HZGeIT1DUJfcJBbHl95hY63tWkSL430AJEzUMjSgRFUBDiRoI=
X-Received: by 2002:a05:6870:e2d4:b0:1f0:b31:9b7 with SMTP id
 w20-20020a056870e2d400b001f00b3109b7mr19387156oad.43.1700118361683; Wed, 15
 Nov 2023 23:06:01 -0800 (PST)
MIME-Version: 1.0
References: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
In-Reply-To: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Thu, 16 Nov 2023 08:05:50 +0100
Message-ID: <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com>
Subject: Re: Filesystem test suite for NFSv4?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

?

On Fri, Nov 10, 2023 at 8:42=E2=80=AFAM Martin Wege <martin.l.wege@gmail.co=
m> wrote:
>
> Hello,
>
> Is there a filesystem test suite for NFSv4, which can be used by a
> non-root user for testing?
>
> Thanks,
> Martin
