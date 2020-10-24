Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8B297C52
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Oct 2020 14:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761384AbgJXMcZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 24 Oct 2020 08:32:25 -0400
Received: from mxout1.mail.janestreet.com ([38.105.200.78]:43124 "EHLO
        mxout1.mail.janestreet.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761383AbgJXMcY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 24 Oct 2020 08:32:24 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Oct 2020 08:32:24 EDT
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by mxgoog2.mail.janestreet.com with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.94)
        id 1kWIdT-0000vb-He
        for linux-nfs@vger.kernel.org; Sat, 24 Oct 2020 08:27:03 -0400
Received: by mail-oo1-f72.google.com with SMTP id g14so3170136oov.19
         for <linux-nfs@vger.kernel.org>; Sat, 24 Oct 2020 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google;
         h=mime-version:from:date:message-id:subject:to;
         bh=oTrsMU36tXW5A9OANzv0o74Zco8oRUrV/C2zCUNJE7Q=;
         b=w26FLLknbPuWGq2+MkWE8KrlU4LY5+Zj18jVULbYf98keJHW4QbkXBlkpSs5dEVrri
          B0OWz0TleBcxPG3ZPD12+kcUWQv5M4F7y9tiJKBbAQpgaLMpqnWYBSPmESYdmebYVZHJ
          A1xDC1qrp51lL0SadmbrOqvsOrEFJrFk9n+do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20161025;
         h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
         bh=oTrsMU36tXW5A9OANzv0o74Zco8oRUrV/C2zCUNJE7Q=;
         b=JOHHOyley0FgkfIC3AtzmmgkJBEkzTMNtPBbDgWz9Ds5Q5aBYXuugYFzG58EAH3Jnb
          0RG7ixp3b5XFO3JwjQ69XymH5bTgV/ePJeBK9fEyrGwjGJQ9OSulAxFFawpT7+8VYEsN
          qobWQdEjaQh0u3s6i+dRSwkLosKd9eJVH45BrR1LojE6SJlyVOcPrceTGwPB3EsQ1npt
          kV/l/Woe2li0VTuiyAaUyNS73ACPbvg4Gp8IfhkuuiohlrXE6Pw2xywnkEos1ffC3G0u
          6jGCAP+t5WA6XGZvoBsk4h3GJADyH1ZfDPQ2TtWRe9X2YmrFE65X0n81bCVrLtxsUHKQ
          yyIA==
X-Gm-Message-State: AOAM533yfW7TiMqPA2/OSlYsDq9gej915IvzH8xru+fM0BtRHSGgd4D7
        bTJVveZ7Y7+nFrdxcPiVUuCLLVDkLB0lJib51UsDkUV+9lbBaqucKdFVhJpI0q2IK96yPC4n439
        bjrUrQ63IuDneI00Y39S8JtRTBkwcA47qzz0=
X-Received: by 2002:aca:3806:: with SMTP id f6mr1097961oia.66.1603542422821;
         Sat, 24 Oct 2020 05:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLfuicQ5tn91U+8HRHYFhHnAtl4B6K4Gh0p1+nxpvAH+MBqDTHz9yuHHfHbxCmLMK2+s2bnW23NFWmNWGerfw=
X-Received: by 2002:aca:3806:: with SMTP id f6mr1097955oia.66.1603542422634;
  Sat, 24 Oct 2020 05:27:02 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Hagberg <ehagberg@janestreet.com>
Date:   Sat, 24 Oct 2020 08:26:51 -0400
Message-ID: <CAAH4uRB3Nt=veFgxVUo2pyaBhw84cWahSY+3Tf7rC6ppLZi-dw@mail.gmail.com>
Subject: sm-notify: IP vs hostname?
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've noticed that sm-notify pulls info from
/var/lib/nfs/statd/sm/$hostname files that also contain the IP address
that was in use when the lock(s) was created.

In cases where the hostname lookup may resolve to a different IP
address over time, would it make sense to try notifying the IP address
from that file rather than the hostname of the file? Or try the IP and
fall back to a hostname if the first fails (or just notify both?)?

Thanks,
-Eric
