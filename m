Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500786835A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2019 07:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfGOF4w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jul 2019 01:56:52 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44826 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfGOF4w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jul 2019 01:56:52 -0400
Received: by mail-io1-f69.google.com with SMTP id s9so18739749iob.11
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jul 2019 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elastifile-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=JEGL9vL5k2zIpfsw1wym/aMjvVSZu3SnJxjoHLqwbSc=;
        b=DflHkV/NPuagXGoxxF5wtoMoiU5rmBpaL9HvkKlDiJ4qZgsYT7FNt/to6aBCkwpC3D
         Ml/gDP6qugbFDoaLfKrspo7VMfZWb3pFRmGHfiOtjs3frfALbjoySW31BU/FHNodbrd3
         tXWoHaxMqFZ/lfl/bjqZsqRaw9uyGyZ6z9Bi5TB1nqhElp0QxEUBVDAVfO+om5nGKqJ9
         b0IG4WX32iDdFZiJqRUcaE+qOWzCdf7n0dRQUD09AarDJGPjbuTxC4ZiwK6Ww4SNg88T
         KhKtLNnAzPmw2W/RvrcO1TG7bgz+RuHKHDbPS+9dskq/VY8cfndOIZUyqB3hWcYjw2cE
         X1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JEGL9vL5k2zIpfsw1wym/aMjvVSZu3SnJxjoHLqwbSc=;
        b=oN/R5j1x7OTcutJG1cCgQITCZExKiCDs+exdEXF7tD3CY1MwtCbQTlmW+P5Lh3bcD+
         OnTbGYlAzm8idm9QbcTUfmmdF/gYJCEnUzyqsJ7yUO6Ohmb9VmeCPSmheVRz2B4BUaX1
         Cwgqklt1EX/XW6oF5PJCRIp8Q3a6CNY3uKeVWpV8ijbfjZ/06S9dz/J03SMUIbxHMaih
         JAe0Ov2BV8yJHa0u9te7dIggSYC2uK8UuOBMhkXVnn5QmGtDFMTIkLtk+dtwe/+74Ivs
         fK3EslxFe85EGFNDMtF6zslVW/JMrzo/uygLBF9av75bJaH1+t9YDd2Jrx4wmc1VtJzc
         miLg==
X-Gm-Message-State: APjAAAX7LAGj+0Iy+g8pRf+245S3TceHkKhECZLEIwyK3FboRlPLlUpg
        rvzv5hBE8XJsTpSEZgMGixLhY98zZJG7DCFqKpbOdSBE
X-Google-Smtp-Source: APXvYqzyzhAK0oN9n9m/pugEsyIHWfFWxkngLD9iiXmWHQStA40kBECRmjhm4WKK6vqGc2Tx5J8Edo/xCtBc12EmyOE=
X-Received: by 2002:a02:1c0a:: with SMTP id c10mr26522638jac.69.1563170211087;
 Sun, 14 Jul 2019 22:56:51 -0700 (PDT)
MIME-Version: 1.0
From:   Noam Lewis <noam.lewis@elastifile.com>
Date:   Mon, 15 Jul 2019 08:56:14 +0300
Message-ID: <CALDUuiDyf5mfNVLeTKHNkU+bTbsKLOoHw_rZm1khcaiep-cEDQ@mail.gmail.com>
Subject: large directory iteration (getdents) over NFS mount resets due to stat
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've encountered a problem while iterating large directories via an NFS mount.

Scenario:

1. Linux NFS client iterates a directory with many (millions) of
files, e.g. via getdents() until all entries are done. In my case,
READDIRPLUS is being used under the hood. Trivial reproduction is to
run: ls -la
2. At the same time, run the stat tool on a file inside that directory.

The directory on the server is not being modified anywhere (on this
client or any other client).

Result: the next or ongoing getdents will get stuck for a long time
(tens of seconds to minutes). It appears to be re-iterating some of
the work it already did, by going back to a previous NFS READDIRPLUS
cookie.


Things I've tried as workarounds:
- Mounting with nordirplus - the iteration doesn't seem to reset or at
least getdents doesn't get stuck, but now I have tons of LOOKUPs, as
expected.
- Setting actimeo=(large number) doesn't affect the behavior

Questions:
1. Why does the stat command cause this?
2. How can I avoid the reset, i.e. ensure forward progress of the dir iteration?
