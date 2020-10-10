Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB92128A1B3
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Oct 2020 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgJJWLx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Oct 2020 18:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbgJJUjf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Oct 2020 16:39:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F843C0613D0
        for <linux-nfs@vger.kernel.org>; Sat, 10 Oct 2020 13:39:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s9so2055224wro.8
        for <linux-nfs@vger.kernel.org>; Sat, 10 Oct 2020 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=12k2hDhWLyws9DzSyc+7Hv2NIJg2U6RDEssCuiDOCno=;
        b=jnkGkxSZ2jSehWMZPXZyJIoEjtcoWTX6HzyhEYirsNrMbew4HD+Ry5UdRsJJ/PVUYu
         jxBTX7H94PYuKtQqqQ2KwOfRXPHcmIHY2tj2Vg9Bgm9mgfyyTbETZ3HKZRIC2vAYflOQ
         DZfwGZsML9yA3pWbZuP7HxN/ZUjq9A+ObqXZE4hr1jJWJRdC5Dc+DUgjx2s0eEA3kv4l
         zDtAoeGM/ymO8Gse6XA4qOjTQeYttns//JKYqgrntZ1kQCwgHEuDDlb6FmsgM1KDKvxK
         NYWU/+z/3jxsNKbmzTANn2RGXUO2RAKqf9xNpvl35PEIeC/aBhWKGN6MNAOydnQQQcGF
         oUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=12k2hDhWLyws9DzSyc+7Hv2NIJg2U6RDEssCuiDOCno=;
        b=UzAaRz3Eb7IX44UXk1yas46r/y3YkB63g/7p6i9wMAe1/pOcFIMVh7N499bTOsL2sA
         rUgihabRs5LqsCAj7KZVQLnmOVM+GPkxbhvBrSGzzfOqmJ6k8yM8S5hs8Wd7wVboSXNa
         WiaPOsWDcY3mZNHA1xBMx+dzM7MSS3IHeAfbJ9wQ6eTLcXQ8nRk8Jq+ULPaxREx9y1jA
         8BESW8BTDamE+q1uEowkuUSpnSDmZJGL5vkzZpbOLfXctmAvaVEE8BgeqNh57AuXBqQW
         uDkw/pwXIktd0gTgVxXtSsz/SEKJ5th/p8gBsUS7da070MViLSQz+z2YR9qDEQb8/DYg
         Q9CQ==
X-Gm-Message-State: AOAM533m1rFJXV97wVgMYlckAf++7i0Kkp0MRfd63Zbe3PI/W11UAQFn
        gd7tTqT5lj4zU742JGtTSpQLkKv5ygk+Vc/I
X-Google-Smtp-Source: ABdhPJwX1SudMI4pTBTIMRY4DuU4JxSx5TPaqxGBmlNJRw7FxpXY1u07sl9cML8FwR3caWwoziwAIg==
X-Received: by 2002:a5d:5083:: with SMTP id a3mr4763611wrt.93.1602362373163;
        Sat, 10 Oct 2020 13:39:33 -0700 (PDT)
Received: from [192.168.0.102] (line103-230.adsl.actcom.co.il. [192.117.103.230])
        by smtp.gmail.com with ESMTPSA id w11sm17403123wrs.26.2020.10.10.13.39.32
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 13:39:32 -0700 (PDT)
To:     linux-nfs@vger.kernel.org
From:   guy keren <guy@vastdata.com>
Subject: questions about the linux NFS 4.1 client and persistent sessions
Message-ID: <02b2121f-42d1-2587-6705-ca2aadb521bc@vastdata.com>
Date:   Sat, 10 Oct 2020 23:39:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


hi,


my name is guy keren, and the company i work at is looking at 
implementing an NFS 4.1 server for our existing storage product.


during the design, we encountered some issues with high-availability and 
persistent sessions handling by the linux NFS client, and i would like 
to understand a few things about the linux NFS client - i read all 
relevant material on www.linux-nfs.org, and spent a while reading the 
relevant recovery code in the nfs4.1 client kernel sources, but i am 
missing some things (a pointer to the relevant part in the recovery code 
will be appreciated as well):


1. suppose there is a persistent session that got disconnected (because 
of a server restart, for example). i see that the client is re-sending 
all the in-flight commands as part of

     the recovery. however, suppose that one of the commands was a 
compound command containing 2 requests, and the reply to the first of 
them was NFS4_OK, and to the 2nd it was NFS4ERR_DELAY - will the 
client's code know that after it finishes recovery of the session - then 
when it creates a new session, it needs to re-send the 2nd request in 
this compound command? the broader question is about a compound with N 
commands, where the first X have an NFS4_OK reply and the last N-X have 
NFS4_DELAY - will the client re-send a new compound with the last N-X 
commands after establishing a new session?


2. if there is a non-persistent session, on which the client sent a 
non-idempotent request (e.g. rename of a file into a different 
directory), and the server restarted before the client received the 
response - will the client just blindly re-send the same request again 
after establishing a new session, or will it take some measures to 
attempt to understand whether the command was already executed? i.e. if 
the server already executed the rename, then re-sending it will return a 
failure to locate the source file handle (because it moved to a new 
directory). does the linux NFS client attempt to recover from this, or 
will it simply return an error to the application layer?


3. what NFS server with persistent sessions is used (or was used) when 
testing the persistent sessions support in the linux NFS client? the 
linux NFS server, as far as i understood, cannot support persistent 
sessions (due to lack of assured persistent memory).


thanks in advance,

--guy keren

Vast data.

