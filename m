Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A203170E87
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2020 03:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgB0CjU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Feb 2020 21:39:20 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:34616 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgB0CjU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Feb 2020 21:39:20 -0500
Received: by mail-pg1-f170.google.com with SMTP id t3so647328pgn.1
        for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2020 18:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxace-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=RGvGWHH2WY865BxUYBqWF2qGjTB/rlVbYTPpYFopySo=;
        b=QXOkdQ6slTeiS0yJNsLbKmtBNQVhL07nlWLmNmpLNZCw4YqV48Hhn4gUVQRXls4uPL
         JoUakn1Di41rigYN4//dbtsddHDR5cRktw3IjT6iwIfWGFrfzYc5akL7p5MdQufJNsFD
         hMDUCXWiSA1Q56dfVx7rd+kRVIBNLPTAionUBY6rjpZ4hmZ9U/PJt8VN69uKzAjazq9w
         +YmEA0LecUfMPxQNMS3uMvObZX8TH9LTdsHa5NZ9AKEbdqMuwSqyTSh8mas125PfiMii
         J+QvkHoCbZr113aGL0gKh0J8wMGOib5kQr3mSQ8bss2OPKmYc6zQIbNor6JEzlJ8BluG
         NkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=RGvGWHH2WY865BxUYBqWF2qGjTB/rlVbYTPpYFopySo=;
        b=ech7bPd/U7041r1q1RiAE+cQy/Lbxp7Q6FtnLtQcYkKDH8Dv5zl3v2AAAHbyyBORe4
         gqYGTCznD8U9UngdCqRAY3DWMIyGKW5W8ZVBrPXGwEY0h6T8+nfvqU4H4VsysTzOUNGQ
         jhxMPP3J3ybclG1JDjIknThXjbKRddhBCUsytvDm4xszqTAet4qt+u0jh+W08Q0yI6W/
         UhZwl6Z708qj3ImmlFKs62w/IetVnVjrLLaCfcaS4MD2SKjl2oVAbcpVtUq473wKy9mg
         0Kburj7yOrYxgqaiE1LBssZecEqzkPnHpyQnx3kDWXfW0uJK+RzwAriX3gcW9lBOhXSw
         GdZw==
X-Gm-Message-State: APjAAAVNvrvJrRDtywMBOKlxznMGQsttvfEmVDLi2W1jhLr8DUXZ4kOa
        Hjf9UP2IBKLc9ZG2DoGmGygjes1kAIU=
X-Google-Smtp-Source: APXvYqyDJTB2x9wXkU3DS0rZUUo+wRbPo3poAilsyI6qGCjHNDGaYsHbINZtttp1CGhHoqTI/EqliA==
X-Received: by 2002:a63:4282:: with SMTP id p124mr1920563pga.59.1582771157383;
        Wed, 26 Feb 2020 18:39:17 -0800 (PST)
Received: from home.linuxace.com (cpe-76-91-193-165.socal.res.rr.com. [76.91.193.165])
        by smtp.gmail.com with ESMTPSA id 64sm4408647pfd.48.2020.02.26.18.39.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 18:39:16 -0800 (PST)
Date:   Wed, 26 Feb 2020 18:39:14 -0800
From:   Phil Oester <kernel@linuxace.com>
To:     linux-nfs@vger.kernel.org
Subject: NFS "fileid changed" errors since 5.3
Message-ID: <20200227023914.GC33510@home.linuxace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When running on 5.3 or 5.4 kernels and mounting a Netapp filer via NFSv3
and accessing the .snapshot directory, "fileid changed" errors appear
in dmesg.  Reverting these 2 patches solves the issue:

eb3d8f42231aec: NFS: Fix inode fileid checks in attribute revalidation code
7e10cc25bfa0dd: NFS: Don't refresh attributes with mounted-on-file information

Various condition checks changed around printing that error in these
commits, but I'm unclear whether the errors are spurious or something
I should actually be concerned about.  Thoughts?

Phil
