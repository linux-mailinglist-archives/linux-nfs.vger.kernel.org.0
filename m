Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BFE1FD350
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2020 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFQRUP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jun 2020 13:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQRUO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jun 2020 13:20:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B3C06174E
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2020 10:20:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gl26so3237372ejb.11
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2020 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BuYy1eMYJ4zgqMg4f4qVUB6Tzqz514vb+EP5YZH9NCA=;
        b=nHI1G0/5jfKyNnQbpbZFS8sspMuC/kBhbeGMG4bMyg4H9qP+YbqcxEVbyvMbQvVgic
         AQ3rtTrgzbMsaSNku/738ATsWJmmQhTbQCJLYkUEQXIvJQBbyuv+g7w7kgkjwhcvL4EK
         4HkC1+xZ+i2Ck/BxDv52dlNZWgo1Zkv4/+SGzwtWXtZWkuXvYqID1AmGVio0dseZyV08
         0F7rkKPXsYFV4Tu/tU2qEujpmnTMCdHtkR7ow1LSJcSm2iwAhNzvNgJrctyP3CztDKHm
         gQvhc6OJgp1udpXkgvpQW29YB1XbBqO/hAtn67CsgqP7tLBgT/Isd6gnZ5TZ5hDcS29z
         rCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BuYy1eMYJ4zgqMg4f4qVUB6Tzqz514vb+EP5YZH9NCA=;
        b=IKFxYIzsmv87D1+P7OzD2Iuhgx4XPiK489SBTOKkGUvtMtsrm0OIU5pi9zKe3E/dF9
         deoTEzpGoW9+nzvoFjLUIVh7jrDco5/nTMgo00jijx0wQzwg2JjX9kJUDLz9TyBhUgaB
         V0q+IzsBsnVdL3ZgO+wNKfogjIW3cSY8QoSzGGvMALD4XFk4Fn3C2GneXwhQC54Ev5pH
         yVTFwcBn26HpCNneNkCgjc3/rY8n88fo2frm5DGGyYOWuWqQqSY1IwGyH5mXvt1KVJTj
         rbJmHl52DVZB+Ln3nI3FvSad7aGQEuLMe0bFiMQv1nzJ6eq1BAz9ONds69ByaqMJEoIt
         kPFA==
X-Gm-Message-State: AOAM533buvbuhH/QhtUzP51xXldpdtkNr7OXZKLglHMTNcxvQzRQIEtd
        wi0EkFv+v5NJD2EqrTd5ceU6v8gYbuqf8yRkmggyZA0Q
X-Google-Smtp-Source: ABdhPJzNm/tDr2yuR5oO9+eq3GEc4oxfRuxL4PQm2Lmf5tK7p2NQSFmrQUkWhfEQz3SQMSVOztCgJXF3w6plo0FiW/w=
X-Received: by 2002:a17:906:f155:: with SMTP id gw21mr200875ejb.388.1592414412938;
 Wed, 17 Jun 2020 10:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyFGML84VX79oX-JbMsDeSW4WAA6iyBPjrd4O089iz26AQ@mail.gmail.com>
In-Reply-To: <CAN-5tyFGML84VX79oX-JbMsDeSW4WAA6iyBPjrd4O089iz26AQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 17 Jun 2020 13:20:02 -0400
Message-ID: <CAN-5tyF+xS=WV3tVAsm2g2vCQ9Q7X_bFRFOy0yEJaXx07ciVnQ@mail.gmail.com>
Subject: Re: v3 timeout behavior
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 17, 2020 at 12:04 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> Hi folks,
>
> I have a question whether or not the current client's behaviour is
> desirable. Current behaviour: every time a v3 operation is re-sent to
> the server we update (double) the timeout. There is no distinction
> between whether or not the previous timer had expired before the
> re-sent happened.
>
> Here's the scenario:
> 1. Client sends a v3 operation
> 2. Server RST-s the connection (prior to the timeout) (eg., connection
> is immediately reset)
> 3. Client re-sends a v3 operation but the timeout is now 120sec.
>
> As a result, an application sees 2mins pause. Where as if a connection
> reset didn't change the timeout value, the client would have re-tried
> (the 3rd time) after 60secs.
>
> Question: so in sunrcp if we get errors CONNREST/CONNABORTED, should
> we skip adjusting the timeout?

This is what I have in mind:
aglo@localhost linux-nfs]$ git diff
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 61b21daf..26be473 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2413,7 +2413,8 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
                goto out_exit;
        }
        task->tk_action = call_encode;
-       rpc_check_timeout(task);
+       if (status != -ECONNRESET && status != -ECONNABORTED)
+               rpc_check_timeout(task);
        return;
 out_exit:
        rpc_call_rpcerror(task, status);
