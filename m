Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED23121825
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 19:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfLPSlN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 13:41:13 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33232 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfLPSlN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Dec 2019 13:41:13 -0500
Received: by mail-wr1-f45.google.com with SMTP id b6so8590019wrq.0;
        Mon, 16 Dec 2019 10:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=dmiMgoD75AAcjw9CAZdw1UHn0tTsdKG95qJoZRe609s=;
        b=ngqFTy3olA305iYX6EZqcLN+BQjyz2wKMWgz3dJ2m8O/tyEtLn7SOCWPza8nJMh4zn
         XveTtlWQA+GDN57VINSxnK2ca3s7OUIEa0r8qTD7fnVOOikzEaPTXnwHi8asYPJXPlwx
         KwmYlZJ2lEw3bCsDVw+VtgH/71J5IQsVxSbjs0AemXIb6gNljIc36geRdKxfvDgfIgWu
         1fEeMk2d/t2o7dHcpNxjDppkb8lFfnIhXrtDnlTAzOfyHUW9sfFNWuZlKkNnFeou+ui1
         IR2EZRSCtt7uQTCOD50N9UNiRa1LTn7jFw2VP+FjoK9eDUAllIUVlJgn4RArjydl3Gc+
         1vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=dmiMgoD75AAcjw9CAZdw1UHn0tTsdKG95qJoZRe609s=;
        b=iNLadC+dy8zPHAOeyj6RCfOUqSMDDDe+VzDGX3fSvnvh2C5VQ4XLlumjQZ4hU7eNe3
         ps/v85WodOjzZi6SkMFDxWlWLid4dI1sodBhkRZjUTFK3Y51/W0U+URpeGz9nukdC7Nu
         XCjTqs9A4t4gLsfR5uXYQS3uCrhgN6MWobvsbrD3qdwiV6wecvfhN4YY/Mm9VuKfaYxq
         Zg9zK31z4kqTSs2OpnBsYOVrLWDWgRBrd0eQ95ZMut3xlYINEUsdhu7HrmS1sQZSEZVz
         tuO2liB85RHJsHMbEuX2P3Qx691SC7DDVArPxzVsdNt/KguVulJVbQxJvuoa6Y9wYZdN
         j+kA==
X-Gm-Message-State: APjAAAWGvd2S1SwYbtVXnGuoSkip8qu/rwMcNeZgipSVlSf+yEaE5yOf
        bi+7qtTLNnNvS9CJs/yWGLE=
X-Google-Smtp-Source: APXvYqyKkMN/qW4xYNq8UMawoOmvbRZkuOZ+cFL6xDfsqUXPsmPt1FpvM7lRXAbCbYvtCCNI/KiKTA==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr33619339wrv.79.1576521671684;
        Mon, 16 Dec 2019 10:41:11 -0800 (PST)
Received: from WINDOWSSS5SP16 (cpc96954-walt26-2-0-cust383.13-2.cable.virginm.net. [82.31.89.128])
        by smtp.gmail.com with ESMTPSA id z83sm293566wmg.2.2019.12.16.10.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 10:41:11 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>
Cc:     "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>
References: <056501d5b437$91f1c6c0$b5d55440$@gmail.com> <05cd01d5b43f$b7d88f60$2789ae20$@gmail.com>
In-Reply-To: <05cd01d5b43f$b7d88f60$2789ae20$@gmail.com>
Subject: RE: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease renewals
Date:   Mon, 16 Dec 2019 18:41:10 -0000
Message-ID: <05dd01d5b440$63421740$29c645c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIkbnQjyymuSgNjdVHy4DQRhOG+0gKmN4ENpwpw5eA=
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


>btw: Recent ONTAP versions return NFS4ERR_STALE_CLIENTID which is handled
correctly - Linux client will try to renew its lease and if successful it
will retry open().
 
One more comment here, although the issue won't manifest to applications
with NetApp fileservers in this case, it is still wrong for the client to
end up in such a state.
Also, you will need to wait longer (keep unmounting/mounting) with NetApp
filers as they seem to have implemented courtesy locks/delayed lease
expiration as per the RFC.
This means to reproduce the issue against NetApp you need to wait at least
2x grace period + 1 minute).


    
Best regards,
 Robert Milkowski



