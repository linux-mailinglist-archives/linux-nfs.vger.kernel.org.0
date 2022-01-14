Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC47248E9FC
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 13:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiANMgg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jan 2022 07:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiANMgg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jan 2022 07:36:36 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC043C061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jan 2022 04:36:35 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m3so15788887lfu.0
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jan 2022 04:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=bBQsqu4hoFKDggD3Ah73gFjsiwr155j9ZaPwmpMVfeU=;
        b=dINfUmD2r5tO/Z+aqI8mEyH33zCvvGZGRtaOfQRPJ3QKpe3AE4j3qjIL5JRbMy2BFU
         4F46GQxBZmKjQP+/Ih+yIYJcSmyhRKkmqMXJT3E1RYFCOhwN9mMD3BtIOtNLUOu7T0Uw
         fPYaf23/gPpWFHZ5hxM0d97z3mLLAefioscAzi2F6lIclIduo6WD0yrlWRgjM9WF+T5J
         6Rqscj/mzT/Bj34yjrVsljkT55zTvtL/eWL8EbaS/O/mgZGZO1ishG9Kniu9r7W0uptK
         otdieJcdmVUuXWNI9kAwsdHQb4ZOEbPYBbnx90nPe57eOd0OxRFHvnqcmmVbzdYpVWdi
         eVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bBQsqu4hoFKDggD3Ah73gFjsiwr155j9ZaPwmpMVfeU=;
        b=JfdTa8zEn6jSNKrJ6r1UkH+4zsVhQ67gQN/gq12EHQsLS/tC+aJmZAS0SlGKljKqcC
         6Umw3CaX1C7Fx0zwWrauo8ukdIG2+RuzjvwasPtdMPTFxaSgU7M4Em4fkM0wSx7femH2
         ud6RC4idJ4Q7mlwN2GLJatyrUJ8veNqFWqyDTKn0eWhNagMHNU6b3wgoTXcHh1FcC3nW
         o5vLYi1I7nzkfWuFxWpQBDTik8F8FptPQ/eKYp7a5IyFCCzT3Ss5auN24ZPG4MOq5msr
         tgu5fHAvea7NgmmOzaBHSYVyiJnxObWQbSHnQQLUr9WjatuFUEr5tMcr8ea8PcW79wNl
         0u9Q==
X-Gm-Message-State: AOAM5330plNS6kL5F6x17bQ5lvOGRgmdFcfPDeS0enorMDC0vu0I/Gho
        unM6EC9SdvkOIlWXKcS9TKgeGg47Erzkj5IlFUBKHtpVRrk=
X-Google-Smtp-Source: ABdhPJycRFUgrn559KrfCtSyrleTOMPJtq/iXdKOxIRMUSQGrirp56Vzc0UMlAbeWzDc1Tlkpvmfcjbu9U4iuZcxRsA=
X-Received: by 2002:a2e:8550:: with SMTP id u16mr6394751ljj.208.1642163794072;
 Fri, 14 Jan 2022 04:36:34 -0800 (PST)
MIME-Version: 1.0
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Fri, 14 Jan 2022 12:36:23 +0000
Message-ID: <CAAmbk-f7B4jfmhe-aH26E0eRQnOxGGFPr3yHZMv0F4KQc6FVdg@mail.gmail.com>
Subject: [bug report] Resolving symlinks ignores rootdir setting
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I was testing using the rootdir setting in nfs.config to allow using export
paths that would normally conflict with local systems directories with NFS v3.

The idea was to support re-exporting a source NFS server such as NetApp that
might exports arbitrary paths such as /home without overwriting the /home
directory on the NFS server, and even support exporting a root directory similar
to NFS v4.

While testing I ran into an issue where the NFS server would fail to start.
During start up, the NFS server would log the error:

  $ systemctl status nfs-server.service
  systemd[1]: Starting NFS server and services...
  exportfs[2307]: exportfs: Failed to stat /srv/nfs/usr/bin: No such
file or directory
  systemd[1]: nfs-server.service: Control process exited, code=exited,
status=1/FAILURE

  $ cat nfs.config
  [exports]
  rootdir=/srv/nfs

  $ cat /etc/exports
  /         10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_check,sec=sys,secure,fsid=0,nohide)
  /assets   10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_check,sec=sys,secure,fsid=10,nohide)
  /bin      10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_check,sec=sys,secure,fsid=30,nohide)
  /software 10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_check,sec=sys,secure,fsid=40,nohide)

If I create the directory /srv/nfs/usr/bin then the NFS server will start.
Listing the actual exports shows that a different path was exported compared to
the path from /etc/exports.

  $ exportfs -s
  / 10.0.0.0/8(sync,wdelay,nohide,no_subtree_check,fsid=0,sec=sys,rw,secure,no_root_squash,no_all_squ>
  /assets 10.0.0.0/8(sync,wdelay,nohide,no_subtree_check,fsid=10,sec=sys,rw,secure,no_root_squash,no_>
  /usr/bin 10.0.0.0/8(sync,wdelay,nohide,no_subtree_check,fsid=30,sec=sys,rw,secure,no_root_squash,no>
  /software 10.0.0.0/8(sync,wdelay,nohide,no_subtree_check,fsid=40,sec=sys,rw,secure,no_root_squash,n>

To test this further I create a symlink from /software to /usr/lib. Once again
the server failed to start because it could not find /srv/nfs/usr/lib.

Reading through the source, I think the issue is in the getexportent function in
support/nfs/exports.c.

    /* resolve symlinks */
    if (realpath(ee.e_path, rpath) != NULL) {
        rpath[sizeof (rpath) - 1] = '\0';
        strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
        ee.e_path[sizeof (ee.e_path) - 1] = '\0';
    }

It appears this function does not take into account the rootdir property when
resolving e_path.

This was tested on Ubuntu 20.04 with the 5.11.8-051108-generic kernel. nfs-utils
version is 2.5.3.
