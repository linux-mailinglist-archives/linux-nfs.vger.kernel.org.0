Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14775344FC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 May 2022 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiEYUfp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 May 2022 16:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345084AbiEYUfn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 May 2022 16:35:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27777B36C6
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 13:35:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p26so28463217eds.5
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=fwFh7el2i70dgG7ajSBQ97ujNHUmHQr/8dBy/cp538Y0DFJy3GciSk9bfB4PmvFZDh
         tRz7iC6mswnuoWs8xGThaDxiUfL3eeXhC9znmoQjSrqrW1MKwzA34OpegNrGTUOqHK9+
         Nrv973KKEKRRQpWcu74Y3RLKldp+GqH2nk03/vLy5i7ZwVUrVDIuMLCpFA7MquTKhi1Z
         N3MlhrCu1MlbrUAYV5pNcGghZx6qKVj2e5006tJF3OBAcP84Hb99hkE413VZJ5SMmEYA
         qNdGYPicWzr4xb7wwKIyfxR39S8xgH3getFTsqN910e6DZnCwxUkLXHqWwoB3XzqnNyh
         LjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=ps38ZdcWm/0EJuSGg61h0ogieQqY8obUCMcx/JwNY39Q15+qMxkqA4SmrgrmyY4FGC
         hCE7Xng29+kKgHBDWeMq4Yk4GaMVAHbIYxXEMAVVoNE2eYaXtIAT5vmBijmy8eJ8uMT/
         Yqwc2UYEJcIBzq7xg88TyxlJ3CrwKvtDvHANiPVLjZTVajHnIXcoH/Ye+a7jzLt6F17q
         3GjSnAZpY5zWIicwnVpiMXesSqnOiVCmBem3k7nPYqqa1mT3SBbO8J7tI1lqsjACJ4Uh
         Ng86mkSEh58hG6LNH3Ed+/IJ1QXHqaSbJkZdXzJheqrn8PxlC9hmOS4cvX/d6af6IS/e
         LyLw==
X-Gm-Message-State: AOAM533KwttN0UWqCOGqB3yaoz0WqEWUyJTRAJ2lkmeGgc/aeXETwL/B
        H0aj43MCHbgZCyNDHH7S0XT9pAFkEH/gww/szis=
X-Google-Smtp-Source: ABdhPJzhBLyAnkmFel4q9ufiteOClIXhAPTWHVjyaqsfvTP11GQzgetuUHx39OjLI2rC7/KYSZzU0oDmHuYQzPfOn6M=
X-Received: by 2002:a05:6402:184c:b0:42b:d806:dc8a with SMTP id
 v12-20020a056402184c00b0042bd806dc8amr389449edy.79.1653510938673; Wed, 25 May
 2022 13:35:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a26b:0:0:0:0:0 with HTTP; Wed, 25 May 2022 13:35:38
 -0700 (PDT)
From:   Luisa Donstin <luisadonstin@gmail.com>
Date:   Wed, 25 May 2022 22:35:38 +0200
Message-ID: <CA+QBM2rPwkHTQnRgqJpppwp6pWQWJmQLxS0JF0+sTmaFWpfNOA@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Luisa Donstin

luisadonstin@gmail.com









----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Luisa Donstin

luisadonstin@gmail.com
