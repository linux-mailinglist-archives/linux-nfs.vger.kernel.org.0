Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8D2569173
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 20:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGFSMn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiGFSM0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 14:12:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEABD29CAE
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 11:12:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so16531513pji.4
        for <linux-nfs@vger.kernel.org>; Wed, 06 Jul 2022 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=mN3P8hPLWEZdYq/Iq2iVxFahPajjklJmxF0PKn78//uClSCt4VG2U88hiC+11v16xh
         y1SqfQca+JNBVAZI3ePM63ZbF/Ll2WyFBxkuWhi0DbjFZD7bQcGvjfRIWz9nOeUbfrNN
         Hn12zBv/BHEjrzhK9FyYZgJ+0yDe9gXNRwyhqCay9zO0NttAB/+uaRHDNofm5fJJ4uyL
         UE2EskqpdPqCBWA33nmN+zOjdnlOoGQz4kYyfy27QOsJGqWsEfVgJUCLFJ7tUYFz1it3
         polGmHqOxVGn/C/jOAMwwxKSSJA7dpPm8rxHhFZfT3QwVHikUfVhjEQAyBYj6En6JhiK
         ztug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=dlj1QJ/vAqdDjzIPWuPCO78aED9TpQxbXJ9XQ7X2rpEG3C7a/1gQcdGyq7Wpw8yahE
         dd0CbljKds29H12YxwyWSF+PSlWohzudLNRQWLQNeLw6I7arBjHQVUlOdmerTNWx5bw4
         +eh5GTGPKir7R346qCD+ArVaCAIjj2QzyHPIGNuhebrYYQD8VcGkD1WmksbVXjDg3h+L
         4xgIJy/SFwSBEyyKh8RE2ucFCYfAjoHHwVwlasZ0uSAOKzPmBGpQMTiJWIhoPuDmrCoI
         YG6z0+ntSs5jJCtTjBL+6JjmeARiACx4ko4Me9jRfv0iyY/aIx711Xzoi7xYt5i6PkNo
         zR6Q==
X-Gm-Message-State: AJIora/tyFSSedGwVhe+ClMesAqlbS9hdcrIS7HFWRibql3ROdETuiBV
        vnZF50mDCxA5hP0euftPc5qg8MItJDkuEF3HJok=
X-Google-Smtp-Source: AGRyM1tSYQD1ua0CTRUtypz3YJM8n3hdcH3c6IIFHPkFLrrLRVN/+BPxkQjsmeSTaVke5NPWeFiSOZZnJAKztGQjykw=
X-Received: by 2002:a17:903:22c7:b0:16b:fa15:63d4 with SMTP id
 y7-20020a17090322c700b0016bfa1563d4mr7832109plg.2.1657131143717; Wed, 06 Jul
 2022 11:12:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:688:b0:2b8:44d7:af7d with HTTP; Wed, 6 Jul 2022
 11:12:23 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <sidimadi424@gmail.com>
Date:   Wed, 6 Jul 2022 10:12:23 -0800
Message-ID: <CAMKkZLv4y_z0FHKzrstmY9iWS6F=dqe-=gTuDKKGrJQyOX5=9w@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
