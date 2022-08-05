Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ACE58B2B7
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Aug 2022 01:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbiHEXR7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Aug 2022 19:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbiHEXR6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Aug 2022 19:17:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A201811C0E
        for <linux-nfs@vger.kernel.org>; Fri,  5 Aug 2022 16:17:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t1so5317283lft.8
        for <linux-nfs@vger.kernel.org>; Fri, 05 Aug 2022 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=sLkqhWS0z1StVd37v6tEtv9+l8BvQZP/Jy1+OiWgKb4=;
        b=dfsrVISdOklaGakzrtQrlHJ8V1tNkwzAsnG9RrJD5jhMNo/JkBIors/iIL36ImT9Q6
         4Lef7XPnzkuIDP8VzJYa9fKQ0ANGsPeVtV66W1Hn6QokPhRzSh3a76ZmArY/9lYc7GRZ
         xOHWITJGofONn0CPzNQ4QX5yJr90M17wY4EBSmg8X01NohIlwTi/8pCx7z41YkgJ071O
         0IjcM64LhGo2Jvntb3dBNYSuP+qFaRrPvqHX33ZKsZX4d+1Bqjhb4u8GHBYyd4ypfrit
         b7pnTpxm69WDc7nMTV48smfUdh7eZgEOw1oKa6N6ucsVvwajEe0Zv/8VSgYE9EosvG6W
         dpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=sLkqhWS0z1StVd37v6tEtv9+l8BvQZP/Jy1+OiWgKb4=;
        b=dX/r7yQ6Q/Du3sBV4Y/7eKiEd4U7Z33f/Fc+aqbY7jDLO0kM09m97rrjbrtSNCyeRt
         958BSg6Ezsugve5vho9fdWIXbVHWyb2ld37u6nOnf1hLUgL+Buu4aCwUpHadM5+xIZqN
         bQ5HgAfCFrJUvYRdzmRjLT0nVnNxQaMwomVyqSwDCV1JeH4CGSJMUB2o9cfKwtTm2Lzg
         q7oKp3mNU06Dnbsbpghi8r6JfLTBQZYYiEx5rR1OlthQ71umKmXVb4u0Z2sy3/L3gen5
         jOm/A3B9iGBgBHf9Csudyr4wuWdk1e8HIu2SqgoODFp3aOC8ewEthwHQfmY1XDi4rIsF
         KCnQ==
X-Gm-Message-State: ACgBeo2h/+WD/+xLvQ2QZ4L+1YGW80TgQDGy7Kttk4SzEk3Pvm8WhEk1
        MqA0QtrAUnOSilQjxxGvSxA7lEm5iPCHUelTOFnthFBPwjA=
X-Google-Smtp-Source: AA6agR7z3ehyp7NcfKFfE2O7NRTmKNApuEgQGf5HdAMKaLJwXxTneoUK0BmNkxjbd4kl+jPisRGUsTFmItXpYvSynsk=
X-Received: by 2002:a19:5e55:0:b0:48a:f08a:6c3c with SMTP id
 z21-20020a195e55000000b0048af08a6c3cmr3018940lfi.56.1659741475384; Fri, 05
 Aug 2022 16:17:55 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Kasiak <j.kasiak@gmail.com>
Date:   Fri, 5 Aug 2022 19:17:43 -0400
Message-ID: <CAD15GZf0FtU81hwQ+brhnt+sv895=TpAuz-YrMtjfx__FJ28Gg@mail.gmail.com>
Subject: Question about nlmclnt_lock
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I was looking at the code for nlmclnt_lock and wanted to ask a
question about how the Linux kernel client and the NLM 4 protocol
handle some errors around certain edge cases.

Specifically, I think there is a race condition around two threads of
the same program acquiring a lock, one of the threads being
interrupted, and the NFS client sending an unlock when none of the
program threads called unlock.

On NFS server machine S:
there exists an unlocked file F

On NFS client machine C:
in program P:
thread 1 tries to lock(F) with fd A
thread 2 tries to lock(F) with fd B

The Linux client will issue two NLM_LOCK calls with the same svid and
same range, because it uses the program id to map to an svid.

For whatever reason, assume the connection is broken (cable gets pulled etc...)
and `status = nlmclnt_call(cred, req, NLMPROC_LOCK);` fails.

The Linux client will retry the request, but at some point thread 1
receives a signal and nlmclnt_lock breaks out of its loop. Because the
Linux client request failed, it will fall through and go to the
out_unlock label, where it will want to send an unlock request.

Assume that at some point the connection is reestablished.

The Linux kernel client now has two outstanding lock requests to send
to the remote server: one for a lock that thread 2 is still trying to
acquire, and one for an unlock of thread 1 that failed and was
interrupted.

I'm worried that the Linux client may first send the lock request, and
tell thread 2 that it acquired the lock, and then send an unlock
request from the cancelled thread 1 request.

The server will successfully process both requests, because the svid
is the same for both, and the true server side state will be that the
file is unlocked.

One can talk about the wisdom of using multiple threads to acquire the
same file lock, but this behavior is weird, because none of the
threads called unlock.

I have experimented with reproducing this, but have not been
successful in triggering this ordering of events.

I've also looked at the code of in clntproc.c and I don't see a spot
where outstanding failed lock/unlock requests are checked while
processing lock requests?

Thanks,
-Jan
