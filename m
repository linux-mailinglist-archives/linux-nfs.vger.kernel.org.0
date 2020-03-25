Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4727619259B
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgCYKav (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 06:30:51 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40475 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgCYKav (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 06:30:51 -0400
Received: by mail-lj1-f181.google.com with SMTP id 19so1833969ljj.7
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2020 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2vx7juo2SrcWwCvw0JhtUEkwXLe4JTpokN+5rvlXIBQ=;
        b=JqK87J+gCehU5QntYxpZZ1q0wjOWXZxZ+Mx+Qa27DFkNfrimjV9L7ZmCVcoiDI7Ql+
         fR+aykLygUWkQY71DuvLMFDS/nLFqMKT4q//T9Kum/e2k0Te7UCO7FWVCFo1xve5putk
         mQTt3nHeIL9cdOcwLGCBGCARuDO/E4OKClT204i+KIV4JiVwQ62HfsTC/3PK+s23qwWn
         Xudvw9enFQFwaYQjOSx6CSlGMMSRncBf34YikTP+jrQdgyc26RNhEX0BmyQhd9hasBu7
         a4stwNd93dfRV7SAfbllkTnEA10fuZGShc0TmvHOxq5iZVSVF2Z0JjpIb+nrXaXRGbHW
         xWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2vx7juo2SrcWwCvw0JhtUEkwXLe4JTpokN+5rvlXIBQ=;
        b=sBVDg+WtzUUuZiLu5VgL0C3Fjveto9FlzO3+dpswz5FF5XORaYphOPQuCSqJBbNltT
         vt0L/5kl4dSkyCRwe8C5ksvXk9TM4aAbz5+FUI0MGhfWh5p+RBA54gbqktj0xUHIfx/R
         cqdzS97hCLkFY9Y9r8OMPnQ2px+OFflf7oDgFtFjLPx+7cK9TcbpYrsNEyJnfT9nX+jy
         N2gV8HQuF65wqKgnHOhNlsfViYmFnV/QoqY4e3TVC9qOO6GhE1U00KxF8bh+zugOKJr+
         Drruh8pOp4HQbw0Fuq8GU+WN0BrUDglJRTRcnoy9NimSUVpiGmzse0tmz2+ZyOF5MOz4
         LxeA==
X-Gm-Message-State: AGi0PuaXYbME81mtLyYowe3xRGOzbyuk1Bp9RBffqvCsagiKk9kl2cD2
        HyhRlIe51LkkH6wdVr7boUJ3RYBll/Z1OehKQisquCJ+
X-Google-Smtp-Source: ADFU+vudzHjyQ9Vr4tcgud2Nt4IHmrJx/GD6v56O7l4WQ+/Ec9kfyqiezx6wQexKC7UC8Whbf7Z4i7lBxUmZLQjJbkA=
X-Received: by 2002:a2e:964e:: with SMTP id z14mr1626886ljh.44.1585132248069;
 Wed, 25 Mar 2020 03:30:48 -0700 (PDT)
MIME-Version: 1.0
From:   James Pearson <jcpearson@gmail.com>
Date:   Wed, 25 Mar 2020 10:30:36 +0000
Message-ID: <CAK3fRr_Yh9Ko+E3-=z6g8p0vvUA9QW+PAoQ+ct3EWya9_oxZ3w@mail.gmail.com>
Subject: Stuck NFSv4 mounts of Isilon filer with repeated NFS4ERR_STALE_CLIENTID
 errors
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We're seeing a number of Linux (CentOS 7.5) clients getting nfs:
server isilon not responding, still trying'  from various exports from
a Isilon

I appreciate we're using a vendor's Linux (out-of-date) kernel and a
third party filer, but if anyone can give me any pointers of how to
debug this issue, I would be grateful (we also have a support case
open with the Isilon vendor)

Running tshark on a client when this issue happens (taken several
hours after the issue happened), we get repeating:

  1   12:18:11 10.78.201.95 -> 10.78.196.184 NFS 194 V4 Call RENEW CID: 0xde68
  2   12:18:11 10.78.196.184 -> 10.78.201.95 NFS 114 V4 Reply (Call In
1) RENEW Status: NFS4ERR_STALE_CLIENTID
  4   12:18:16 10.78.201.95 -> 10.78.196.184 NFS 194 V4 Call RENEW CID: 0xde68
  5   12:18:16 10.78.196.184 -> 10.78.201.95 NFS 114 V4 Reply (Call In
4) RENEW Status: NFS4ERR_STALE_CLIENTID
  7   12:18:21 10.78.201.95 -> 10.78.196.184 NFS 194 V4 Call RENEW CID: 0xde68
  8   12:18:21 10.78.196.184 -> 10.78.201.95 NFS 114 V4 Reply (Call In
7) RENEW Status: NFS4ERR_STALE_CLIENTID
...

My knowledge of NFSv4 is sketchy, but from my (partial) reading of
rfc7530 shouldn't the client be sending a SETCLIENTID in response to a
NFS4ERR_STALE_CLIENTID - which doesn't appear to be happening here?

Although the server hasn't rebooted since the client mounted the file
system - so not sure what might be going on ?

We are upgrading clients to the latest CentOS (RHEL) 7.7 to see if
that 'fixes' the issue - but would appreciate any other pointers

Thanks

James Pearson
