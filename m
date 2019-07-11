Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34CE66062
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2019 22:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfGKUGU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jul 2019 16:06:20 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37564 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfGKUGU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Jul 2019 16:06:20 -0400
Received: by mail-ed1-f42.google.com with SMTP id w13so7052354eds.4
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2019 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delphix.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=5xa2GLNiT/wtEtQZiG+QK7tXvyS039Fn6L3dZW/DaYk=;
        b=HXzOxswYIT1q5YGJeOTLEnNgenAsBrD7FzLFH9b5/qnTrNfMSSgC4kayFWzzAf37oD
         Z/H8nPHVWrm0t3BK9gWr+xJfGE55rIJvsZeRXIbwtRZZhS54882dLzYc5NxKdHESATYM
         +Xq4rCU5nUS/YAshwOi/oJuEYGeanvtjRmzHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5xa2GLNiT/wtEtQZiG+QK7tXvyS039Fn6L3dZW/DaYk=;
        b=gJPUCaj5Enbw6pN28EIM/SkZke+PPnzaWrRlGtw+nVLi7Ho3SxGNy9n5l7P/JFxn5N
         hfDu8KeDdYRlN3SmKvcnilIJaaS7m0dX9frT+wmF9eE0E7bQFTOhcwl5WoB+vyg70fzS
         HzWcCF1D/c9UjlLKK8laux6Bg0jMQxq4oa0jzp0bnsbnh2hZFqL9AVKqNzj8ZExa1NUC
         cr5IMi9QC2vRxEovEVhUz0Xjdv01vikhWdwTMj+6mCSq648Gp9w1gtiE99XaW0XQaCyQ
         ot70lCX9uef45Q3ZwnUpCknMSzH0aLqFCz4AdJjSXyuNL5AmpqQQWe5qpu8FCOzgbl40
         SUag==
X-Gm-Message-State: APjAAAUikxXx4NKaWH528BIRN0wy5KN3PPnKdoQrlyq0FVWvafC6rTxT
        EUpHx6oX7Wsal42kInrUVzkdnqCcI3xtfLc1kbyNXGaAiNY=
X-Google-Smtp-Source: APXvYqxpHCq2uqhG4ulE8XKJFVl1LVEFlk6yEL0nA3DHbHTsDy9Aw+RQUSGHmqI8wyQ8YIsfMytDxy68qyVNCOwBygk=
X-Received: by 2002:a17:906:2289:: with SMTP id p9mr4867795eja.249.1562875578108;
 Thu, 11 Jul 2019 13:06:18 -0700 (PDT)
MIME-Version: 1.0
From:   Donald Brady <don.brady@delphix.com>
Date:   Thu, 11 Jul 2019 14:06:07 -0600
Message-ID: <CAPEr6wVVyU88Km+hWVSv8jQhm2-Z7OV1vQZBr1rtLYeoaYr_ug@mail.gmail.com>
Subject: nfs-config.service fails to apply no-nfs-version after a reboot
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFSv4 bug: nfs-config.service fails to apply --no-nfs-version after a reboot

Server kernel version: 4.15.0-1043
Distribution: Ubuntu 18.04.2 LTS
nfs-utils version: 1:1.3.4-2.1ubuntu5.2

Summary
There are various configuration options for the nfs server that reside
in '/etc/default/nfs-kernel-server'.  To disable NFS versions 4.1 and
4.2, you can specify:

RPCNFSDOPTS="--no-nfs-version 4.1 --no-nfs-version 4.2"

The nfs-config.service consumes the above RPCNFSDOPTS and creates
RPCNFSDARGS that the nfs-server.service will pass to rpc.nfsd(8) for
its ExecStart (see results below).

$ cat /var/run/sysconfig/nfs-utils
PIPEFS_MOUNTPOINT=/run/rpc_pipefs
RPCNFSDARGS="--no-nfs-version 4.1 --no-nfs-version 4.2 64"
RPCMOUNTDARGS=""
STATDARGS=""
RPCSVCGSSDARGS=""
SVCGSSDARGS=""

In turn, rpc.nfsd  parses the version info from RPCNFSDARGS and writes
it as  "-4.1 -4.2 -2 +3 +4" to '/proc/fs/nfsd/versions'

However, after a reboot, the initial state of versions is "-2 -3 -4
-4.0 -4.1 -4.2" (i.e. nothing is yet enabled) so the kernel ignores
the '-4.1' and '-4.2' since it thinks 4 is not enabled.
See https://elixir.bootlin.com/linux/v4.15/source/fs/nfsd/nfsctl.c#L608

Note that if rpc.nfsd had written versions as "+3 +4 -4.1 -4.2 -2"
then the attempt to remove 4.1 and 4.2 would have succeed.

As a work-around you can write '+4' to `/proc/fs/nfsd/versions` after
a reboot before the nfs-server.service runs rpc.nfsd

Thanks,
Don
