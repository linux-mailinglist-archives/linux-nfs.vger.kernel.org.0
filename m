Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C043A21DF40
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2020 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgGMR74 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jul 2020 13:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMR74 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jul 2020 13:59:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DDEC061755
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2020 10:59:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lx13so18299822ejb.4
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2020 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=xNvxoCz7Mp5464lbBv05k7AeNL9BQvXXrySnTgOjdk4=;
        b=FaSn7QUhd+rul39FmOjXoXVeJbi77I0qowfJvbGl3maRBBmWXYIEu5xnY0mZkqqXQM
         ift5a3XArjRFWL9CQoxaod3F2+F2mtvGXPjEVJeUQ0a/ktnPQuq/5R35uxhXa3LSgURX
         vvR55ZpPuavjSp8WfXTDg1isslI6UrXtWEDanRwY3rz7jGDM9wg2f+8gF3U/KL2qxV7T
         R/caCv3b+i9+cB8BgoaRxFubiuOQSD7M6SqpG+Qm9pWqHiZDlch6vvRg6WSfAlGXgL+x
         BQdRSRxodtYKirD4VAO5mGTv8/v7Twbq7d93t3rZ9h5te/ilCg3plRR8OHS6d9oHprhJ
         imOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xNvxoCz7Mp5464lbBv05k7AeNL9BQvXXrySnTgOjdk4=;
        b=j4cE732IYOFC7Z7DjWB4m0i23fe3t+COcnzBiy8/msk671ViCJRHiYNJzNNNo+czeJ
         gonNjihZJtN/QJfxeX9JdJoUIKEt0nl4YWQzM5OAkI2qQarzls1icJ1Fv+Nf8diViAJl
         SLib5d8aJVpbIXxVce1hII+tg3Uoza3BDrB8MHQlRj1XMWyqWjjBaEydSKlSwuLIYD55
         TcRLWY1bV3OZesWcfunxcobCNGUYBuCsw0drk8W8R/fIGPy/0JJ5xbQiIDAzA4K+BmaB
         EZH+rsss0uxw/pYE1aJh91X/IIwI4n+8Zgnn0NIqsdNsY966gLbVetO+og7PkCsOskhc
         VjdA==
X-Gm-Message-State: AOAM530OgWuyK4pdQALpDuWAfe6MIQy3ppLHZWOBKbFZdBcGD0TY6wig
        oxbncAbFMvWQq1WEaigZPPCofTI4a6tJQ/Ykf4zT/m85
X-Google-Smtp-Source: ABdhPJziUPIvmGdtWHY6d5tQ/ObtyA+GutvVI13852gnq4FHmzrfG1QmGGqkXtVll6bpkcJijj5Imu4mgh5rYRG+zlE=
X-Received: by 2002:a17:906:c35a:: with SMTP id ci26mr784117ejb.451.1594663194781;
 Mon, 13 Jul 2020 10:59:54 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 13 Jul 2020 13:59:44 -0400
Message-ID: <CAN-5tyF+NOK3bZpuTSEjnuuY3XnjrarUwHcvh5TEgCBebW=KHA@mail.gmail.com>
Subject: question about handling off an unresponsive server during lease renewal
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

To the best of your knowledge, does the client implement this part of
the spec that deals with when the server isn't responding and the
lease is timing out.

RFC5661 section 8.3 talks about:

Transport retransmission delays might become so large as to
      approach or exceed the length of the lease period.  This may be
      particularly likely when the server is unresponsive due to a
      restart; see Section 8.4.2.1.  If the client implementation is not
      careful, transport retransmission delays can result in the client
      failing to detect a server restart before the grace period ends.
      The scenario is that the client is using a transport with
      exponential backoff, such that the maximum retransmission timeout
      exceeds both the grace period and the lease_time attribute.  A
      network partition causes the client's connection's retransmission
      interval to back off, and even after the partition heals, the next
      transport-level retransmission is sent after the server has
      restarted and its grace period ends.

      The client MUST either recover from the ensuing NFS4ERR_NO_GRACE
      errors or it MUST ensure that, despite transport-level
      retransmission intervals that exceed the lease_time, a SEQUENCE
      operation is sent that renews the lease before expiration.  The
      client can achieve this by associating a new connection with the
      session, and sending a SEQUENCE operation on it.  However, if the
      attempt to establish a new connection is delayed for some reason
      (e.g., exponential backoff of the connection establishment
      packets), the client will have to abort the connection
      establishment attempt before the lease expires, and attempt to
      reconnect.

SEQUNCE op is sent and server rebooted, it's coming up (but not responding).
At the TCP layer, TCP is exponentially backing off before retrying. At
some point the timeout goes more than 100s. Which means that by the
time the client resends the server is up and out of grace.

Does the client have any control over not letting the TCP wait for
longer than the lease period and instead, it needs to abort the
connection and start the new one? I mean I sort of find the 2nd
paragraph in contradiction to the fact that the client must never give
up on waiting for a reply from the server? But maybe this is a special
case where the client is supposed to know its lease hasn't been
renewed and it's OK to give up?
