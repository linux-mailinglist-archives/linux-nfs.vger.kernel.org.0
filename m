Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85BF1FD182
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2020 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQQFJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jun 2020 12:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQQFJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jun 2020 12:05:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51948C06174E
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2020 09:05:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y13so2960814eju.2
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2020 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=DrzBWww1V84LG+Cn2vLmslckbTRUxnfObYgs0yW9aXI=;
        b=gtOrchaCEiqNu1T4nLNfpXKoJGSRBxRT+xjuR0LE8idgFkLzLB8U2eFvYFFHEQtedw
         c77V1lrLIITBVgP/D0Bygjdd2+1Z8YVFbsYImUaW11IWV4wY+b5vb4f4E3XayizAv9lt
         d3xm8sfDyhWvI8WYZYbR3ctLqZU8HSk1sZtZVFcf7dFN6xPgNKNpAMwq+J0Vg7eBp1ye
         i+VfYyUjNQV8WxzPSayfPTyvQAPKiInbqUznvjMtRuEpn3aCA4+oGk6kqvRo7ae8dfMJ
         OHkhP5QiKHEi4SaEDn8K9sXlyk5ngWVWyZ5qsDtF1L1jSExeGGQbM05U6K6gxPQQz+zz
         LmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DrzBWww1V84LG+Cn2vLmslckbTRUxnfObYgs0yW9aXI=;
        b=s4v4spvMHCLu0n7YdtqJHo3cdNvpeTGDYWr/5TPKYhrNJZCc52CbAwEmSXJVdoXoCS
         Y5JGC9t3UBj8oRxKqnvhASh6JuTAtsBAiI5RhZmqdNRhHY4a08nhTnXkqdAvOCipSWrK
         zLGVZrypQrzPJuMu+EI2ZEfabeZLOGyEhlBifpXqet59rHcK5MVsb6dvd1SwWN31bjQ9
         68blMl/TuLCZ/PPv8BDqce0uEzvP3x+1FAbezGKD7nabzdXxbvvwrb7MJ0XrswPRq0cc
         VTFJOrJ45yVWvLxhD+WoLsSm1mSo1L3EYu8zucfrCYvG1FeSCoVJnXg2YrJlpnpSzv+T
         gI+w==
X-Gm-Message-State: AOAM532QZVagwfK/MUvvrJN1uN1MpbvEkYVq1Mkj5JMQm6w24DtyKNGR
        iVzBEb5mw9Z/5lSb1srgDOQp50Ns1Zhdqb4POdXu/g==
X-Google-Smtp-Source: ABdhPJyu+Qdb4Aiz5GJ13V5k64FaZgHUIgbjEL8hBabia5/KQ3REbdtDtcJ7xfaesa+kCIDixCW7oD54uay2+MDyf9E=
X-Received: by 2002:a17:906:39d9:: with SMTP id i25mr7975155eje.510.1592409905621;
 Wed, 17 Jun 2020 09:05:05 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 17 Jun 2020 12:04:54 -0400
Message-ID: <CAN-5tyFGML84VX79oX-JbMsDeSW4WAA6iyBPjrd4O089iz26AQ@mail.gmail.com>
Subject: v3 timeout behavior
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

I have a question whether or not the current client's behaviour is
desirable. Current behaviour: every time a v3 operation is re-sent to
the server we update (double) the timeout. There is no distinction
between whether or not the previous timer had expired before the
re-sent happened.

Here's the scenario:
1. Client sends a v3 operation
2. Server RST-s the connection (prior to the timeout) (eg., connection
is immediately reset)
3. Client re-sends a v3 operation but the timeout is now 120sec.

As a result, an application sees 2mins pause. Where as if a connection
reset didn't change the timeout value, the client would have re-tried
(the 3rd time) after 60secs.

Question: so in sunrcp if we get errors CONNREST/CONNABORTED, should
we skip adjusting the timeout?
