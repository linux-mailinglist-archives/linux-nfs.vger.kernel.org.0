Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC08659536B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 09:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiHPHHv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiHPHHg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 03:07:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476DA8606D
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 19:41:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r22so8104329pgm.5
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=namolCRw6lfeOzEubChBAcAldJ64QnTBesyE0AiqIUw=;
        b=QPg/Jl4p8WwvNgYR4qUvKBY+o1akhyHJJktJ0Fgof+qjSOcZmdGj43v47VTmma3vY8
         tp0zcC73hj07+4nvV84Z/IezIWIjFP1TC+hIiyDk8coc5bgI8xXxV+Igq+ZqgMr5BAG7
         mUqe2VRPE55cQlVskO/S+pOnduuI/GdXhudQZNoz9Q+3cgY32q4Uq6bSLqHEo9xi52iX
         pOeJH/Rhh7GWpGQamSttlCymu9R/cuAwOlquSA/TRyifZZMCIDtbfkJFvsATeaXAeXyC
         8UJCJ6HRBwJ1fdlDQVCLPk3nlyEKvbUDRbbi5XZyOckfXgG4R1UaO/mYcu1NTWdMo9Sx
         a0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=namolCRw6lfeOzEubChBAcAldJ64QnTBesyE0AiqIUw=;
        b=NYmR60wvj1kaQGr+k1l1gnvVjooAXhqiv5Iw8UwuXz1yxhJ1mePA7WgntzmT4LRCui
         ZKTnCh9pMuu1vwFPG9e3EkfxXecm7OjTMVV/aybAxuhF5DyDId/SC9xm39y7pKODcPtf
         wulGXpjF7uyBIVX7JpttHB//xzPeGv4wGgV/4obBrM6BiiP0U4IFUwuORnEIM7g589iS
         1DHDdqRTK1Ykkbyon74BCvXvO2m91wiRTo9yfJ8UIOu1YceJCxiZ1lji7gSAQc9TFFFs
         elac0Vh3g5bDtcsnsJWfXrk3MY2gZ6ZkH6s6tf6xBIYaPitKgqkubD8PYq/M5EJDNTqf
         w4BA==
X-Gm-Message-State: ACgBeo0I01YwM8y6VgqgUtKEXNoc3oOwE78Do0r2zzylGe10QAj2rmrd
        AZC/TCbDgdWkAN6X7FS+gL4=
X-Google-Smtp-Source: AA6agR7kgBo+SZKAH4TQLp2+hoZOl03BJhce7fmrfQFG46mtTRhiRHtAqk+u3AjuNbRG53sHQKfXRw==
X-Received: by 2002:a05:6a00:a08:b0:52b:fd6e:b198 with SMTP id p8-20020a056a000a0800b0052bfd6eb198mr19104003pfh.53.1660617688492;
        Mon, 15 Aug 2022 19:41:28 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:a0f0::bb7a])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090a2a0600b001f1dc5aa675sm5206986pjd.16.2022.08.15.19.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 19:41:27 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     raj.khem@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Detect warning options during configure
Date:   Mon, 15 Aug 2022 19:41:26 -0700
Message-Id: <20220816024126.2694053-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815215511.2595236-1-raj.khem@gmail.com>
References: <20220815215511.2595236-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please ignore this patch. It was not right one. I am sending a v2
