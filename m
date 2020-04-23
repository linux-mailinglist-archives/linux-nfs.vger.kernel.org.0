Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8E91B64C0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgDWTts (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgDWTts (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 15:49:48 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC05C09B042
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:49:48 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c63so7832478qke.2
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JydxOVkRQs09TE/qgxgfXOHiZRek0jYCxIC3ncbqfOU=;
        b=Viut8d1fT+aksXOGavDZe6jv8TEDVdbydfZ3Cj5U8BYoi3eYbkaSRIlx6UzCxe4w5/
         VYxeKp2cu56Vn6l1XHtUmnfDW8EBQtdbcz5RbpFedX5F48rwbBKuQx8Aosj+e7xFSJuc
         2mgbWVEYAv5xafeixKM35dnzdLLW8hqOeILE71wCOurJ462avET3g+mgGb0OFpIN44P9
         w3QNpvjO5hMFGhuF2pdyPpGqtHftCjQ6JLxilB6vV/AcDCQwzKX6ycIdWRvx63JJeGas
         JIB7lFJ/eMF0POzjfy+TCDH/YFNEa+Q9kk8WaKV4IPD+blF1Trf4Zz3G/7kOFWEDLNI+
         4DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JydxOVkRQs09TE/qgxgfXOHiZRek0jYCxIC3ncbqfOU=;
        b=qt5ynzqcYkBBnKKn+jrA6DqSj8okqVCcYGBordJjSyFWzYIZKfZX11L7SiG45jPN3k
         OYE6/cYRqItNOw74U/Rj5iTwYLzL52YyoruB95kiydQbIo9oiEXpH+bvEVXnQa8F6kDW
         nsfAA7Ofl3RIQ87rEqDqful8sD9hsVaBGanaXtg7Wr0Mbf4+EetIwO+NyWfo0Ydy00QA
         8UmIcjjlzie9zg3NP4IM56bYMSu50kX34koCD0ex8twqMhzoQ269/myResAt5C7QMK5a
         wDBtiTpXjHwXzF3EykbvlEoCHX0hhwEdNyKwIoUNx3Vv+HS1lA/K0kn2SEhHAlm8ztEW
         Rspg==
X-Gm-Message-State: AGi0PuZrQ1C5j7OA7YOaeZfaCFGekZg/X7DI0+E69bu9LXFutz4n5EsY
        aBhyq08gz6XGpdTA4jWA9lQ=
X-Google-Smtp-Source: APiQypJueE/IxlTI+GxdMewGGdBBg8GW6C/F4QUG7aeuTtbtDsx6woFL6ymXv4086dwo7IZtBmwtdg==
X-Received: by 2002:a37:6191:: with SMTP id v139mr4917700qkb.469.1587671387601;
        Thu, 23 Apr 2020 12:49:47 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m187sm2200019qkc.30.2020.04.23.12.49.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 12:49:46 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03NJnj1d030439;
        Thu, 23 Apr 2020 19:49:45 GMT
Subject: [PATCH RFC3 0/2] umount hangs on sec=krb5,i,p mounts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 23 Apr 2020 15:49:45 -0400
Message-ID: <20200423194434.7923.31241.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've dug into this a little more. Posting these two patches just
as conversation pieces.

The spinning NULL task at umount time, it turns out, is the kernel's
attempt to send GSS DESTROY_CONTEXT. This NULL is triggered just
as the RPC client has killed all tasks. The spinning rpc_task will
run until a soft timeout occurs, and then the umount unhangs.

Maybe set a shutdown flag in the client, and cause early FSM steps
to fail if this flag is set? Or should the client skip context
destruction if this flag is set?

Any other thoughts?

---

Chuck Lever (2):
      SUNRPC: Set SOFTCONN when destroying GSS contexts
      sunrpc: Ensure signalled RPC tasks exit

--
Chuck Lever
