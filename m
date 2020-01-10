Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2601D137700
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 20:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgAJT3P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 14:29:15 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:36815 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgAJT3O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 14:29:14 -0500
Received: by mail-vs1-f53.google.com with SMTP id u14so1967713vsu.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 11:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=E8OpVKp6QaKf4QhVUGIW43Zlg74ANcKIdcgj47PoCyQ=;
        b=i3lYIs0c0zRjq1FE+FsXa3hL3bm9GiGT0HbfEJRZqCA7bHXBlT+44fVkpbAGFJOmub
         49I+AgObyzPie+Brh+8U+1d+xBOvNaQl6uZLUF1LaZBR2kHPOZV5h/vfB5si2JB41DYv
         YM+h6Ge1p41cUE47o6FaPcn8jG+h8o7xmf6+ybZEeErHsVIZfrb5GEjKIS66cdasQ+Bv
         GBNjjKKq9+4SbENxX40e8szLIX5SC1NO4l3OS3+iyBRkTxa+tXgOUpn2kveC0KD6weyN
         X2ePiErx7G0y+PGm3jdpX6v+KHJ3Y5Rgy9ep/9wZJ63BaCu5KTITDelsEls+UdLR4nUl
         QLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E8OpVKp6QaKf4QhVUGIW43Zlg74ANcKIdcgj47PoCyQ=;
        b=f9Vpoh+ckMcHEzCuxdyRuKBZnR7MDp6YynW9beSQee6MV31mbyIKrHi8sOXrNVaCxw
         8KZkeoru975iGiww3mYwpy9yE49qBfTeatUqtVk4kHsnOb0XEAWd1O8dgBQ7MU/wxsUf
         +eJmMrwfAEM2OjkuAFFsg+4hWeLPMK1zUMyn3KfuQdtWfQO4qFRajycislZmEuCuOkHQ
         EAKX3vuf0viteSytP0PMCHdNTYQ8j6I7WGeNcztiCiSm8ZxeapgOsaNKJaVwflhm4iPg
         n00UWFo11TSN8UwXs8c+7JSA+rC5vMthuHkKqLFh5KrdrIIs2eC2cHeflRBPv8wSp1G2
         qYZg==
X-Gm-Message-State: APjAAAUTW53TT9015bxDZtw82XObdkqs5FP5eGU2XGaFjBtO0uXTAWPU
        MJCTyTpQIVLJE32ELsqA+QWFSGIdHU7kCgreuE0pfOxu
X-Google-Smtp-Source: APXvYqz+ka85hDBKtn441kAW7M8SO5f6ZweDdVZVvxLylhbrBZ9+okMeDHjbg3hiIWJ6b14+N+mU6QBFuADl8y7Rcyw=
X-Received: by 2002:a05:6102:7a4:: with SMTP id x4mr127457vsg.85.1578684553496;
 Fri, 10 Jan 2020 11:29:13 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 10 Jan 2020 14:29:02 -0500
Message-ID: <CAN-5tyFY3XpteXw-fnpj0PQa3M81QGb6VnoxMaJukOZgJZ8ZOg@mail.gmail.com>
Subject: interrupted rpcs problem
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

We are having an issue with an interrupted RPCs again. Here's what I
see when xfstests were ctrl-c-ed.

frame 332 SETATTR call slot=0 seqid=0x000013ca (I'm assuming this is
interrupted and released)
frame 333 CLOSE call slot=0 seqid=0x000013cb  (only way the slot could
be free before the reply if it was interrupted, right? Otherwise we
should never have the slot used by more than one outstanding RPC)
frame 334 reply to 333 with SEQ_MIS_ORDERED (I'm assuming server
received frame 333 before 332)
frame 336 CLOSE call slot=0 seqid=0x000013ca (??? why did we
decremented it. I mean I know why it's in the current code :-/ )
frame 337 reply to 336 SEQUENCE with ERR_DELAY
frame 339 reply to 332 SETATTR which nobody is waiting for
frame 543 CLOSE call slot=0 seqid=0x000013ca (retry after waiting for err_delay)
frame 544 reply to 543 with SETATTR (out of the cache).

What this leads to is: file is never closed on the server. Can't
remove it. Unmount fails with CLID_BUSY.

I believe that's the result of commit 3453d5708b33efe76f40eca1c0ed60923094b971.
We used to have code that bumped the sequence up when the slot was
interrupted but after the commit "NFSv4.1: Avoid false retries when
RPC calls are interrupted".

Commit has this "The obvious fix is to bump the sequence number
pre-emptively if an
    RPC call is interrupted, but in order to deal with the corner cases
    where the interrupted call is not actually received and processed by
    the server, we need to interpret the error NFS4ERR_SEQ_MISORDERED
    as a sign that we need to either wait or locate a correct sequence
    number that lies between the value we sent, and the last value that
    was acked by a SEQUENCE call on that slot."

If we can't no longer just bump the sequence up, I don't think the
correct action is to automatically bump it down (as per example here)?
The commit doesn't describe the corner case where it was necessary to
bump the sequence up. I wonder if we can return the knowledge of the
interrupted slot and make a decision based on that as well as whatever
the other corner case is.

I guess what I'm getting is, can somebody (Trond) provide the info for
the corner case for this that patch was created. I can see if I can
fix the "common" case which is now broken and not break the corner
case....

Thank you
