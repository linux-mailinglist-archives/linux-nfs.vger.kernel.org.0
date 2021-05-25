Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5AF390298
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhEYNfu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 09:35:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51596 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhEYNft (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 May 2021 09:35:49 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andreas.hasenack@canonical.com>)
        id 1llXCN-0005nL-AP
        for linux-nfs@vger.kernel.org; Tue, 25 May 2021 13:34:19 +0000
Received: by mail-pf1-f200.google.com with SMTP id d14-20020a056a00198eb029028eb1d4a555so20432109pfl.7
        for <linux-nfs@vger.kernel.org>; Tue, 25 May 2021 06:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vPuApD306EBLLN5YSqjwXl4ykj2/+3aWdo//1aOD1+4=;
        b=t6m26CzMBrQa2xoJxjBhYXLDrlXHrwB6lxX2YE35+RIAauGXQQmHd+uIiQybvaVaWo
         hJLUjZwUEEwjGp00m/PyuOPAzwTfUsjeFjrI5pg8qx0yt5ysdnS6ZfUTlBGAoIzas1n/
         DyHzEWTwFx+bH8y1pcVBXTaBKpT4VFonSL8AJ8ymqSDlsJVcz+tsgKkS9sojOol24AMh
         07kVZKitGBj/qAGZiGyKzYPwrw/IBnaPwHruGPVtYaMcHXChJJ3lSKX99E//vzymnrjy
         5JqWjB3s+S7/BMBKIpSYEU5LzEh2A+Ib7CaQ+DIMFqm/Ev1zN+nW+Fxs0e8hk0OlsWCJ
         LctA==
X-Gm-Message-State: AOAM530F4kzEY5mfBNCDy9reFXrJStzHVDKH1/Pw6zJ5nUP6NhazgzEK
        BfSdxkypsFRQ1MprdE9o/0hZWskQ8SbGfi3SKrgknltOJfPfTdEfaW059eVaCwRyMdEvQ5vNXfk
        Pw+QPW7/KWqdV1R6octz7cPOo8bxPfVoHBxG0yefwAaql3QrcliZ4jw==
X-Received: by 2002:a62:e908:0:b029:2db:8791:c217 with SMTP id j8-20020a62e9080000b02902db8791c217mr30508249pfh.28.1621949658087;
        Tue, 25 May 2021 06:34:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8Z/9QzW9PvQeufMEn0wIYokNyd4GbqKPjkikQeA5t8tzMuVDWmeYyxZR+oX0d/XaNTIx0+MAG0jt8mWwGyH0=
X-Received: by 2002:a62:e908:0:b029:2db:8791:c217 with SMTP id
 j8-20020a62e9080000b02902db8791c217mr30508227pfh.28.1621949657751; Tue, 25
 May 2021 06:34:17 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Tue, 25 May 2021 10:34:07 -0300
Message-ID: <CANYNYEGAK84yoQ2wDdpQPpaYcBFVo-LAcU7pvEo7H_BVqX1gLg@mail.gmail.com>
Subject: rpc.gssd does not restart after package upgrade
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

this would normally be just a linux distribution bug, and it is, but
it looks like the systemd service files and targets all come from
upstream.

While testing the fix for
https://bugzilla.redhat.com/show_bug.cgi?id=1419280 in Ubuntu, I
noticed that rpc.gssd was not being restarted in post (same thing
happens in debian). It looks like the nfs-utils.service service was
created for this task, but it has no [install] section, so it can't be
enabled. Long story short, in ubuntu/debian it's only restarted in
post if it was started before.

I then checked Fedora 33, 34 and rawhide, and saw that there it's also
not restarted, but with a tweak: the rpms try to restart
nfs-client.target, which also doesn't seem to work on a running
system, but maybe I did something wrong in enabling nfs there in the
first place (maybe I forgot to enable one of the services?). In any
case, I filed https://bugzilla.redhat.com/show_bug.cgi?id=1961322 for
that with more details.

In ubuntu I'll probably work around it by just calling "systemctl
start nfs-utils.service" in post, before the restart routines kick in
(still testing that for side effects), but since the service files
come from upstream, and the intention seemed to be for this exact
purpose (restart on pkg upgrade), I'm sending this email here looking
for guidance on how it was intended for packagers to restart all the
myriad of nfs v2/v3/v4 services on upgrade.

Thanks!
