Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C7E6BF4
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2019 06:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfJ1F04 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Oct 2019 01:26:56 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34866 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfJ1F04 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Oct 2019 01:26:56 -0400
Received: by mail-wr1-f47.google.com with SMTP id l10so8435426wrb.2
        for <linux-nfs@vger.kernel.org>; Sun, 27 Oct 2019 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0ex9MtTWbw5+Te7C09q3bE5eh0O+MaIkl3zChMf9VwU=;
        b=jz/dsB1MpGn/eSvo+EcT6L9Ml4cLhTY8KXcjz8mFzehxeE7UI2jhCBChyjtTeGgc8p
         w2r4Qb2ZDxkrllGWx+KPv5rpHu9Cf+XkpCimxTAvTr3MhpLePoN7/8N2JImI7/GT9elO
         XleYSfmmIwgIT4FHJnaEgwwFsOSK5LmT9v1me/v/iQWEjrkWwR4lOy+da2MqlpK9o8mp
         UoeDOJJLDeURNq+E+7B7Ac9Yqfml3bTg3816L73zoV+pK9/UFVaEUiGxPiZa4ofP8d3t
         gVSGUYkccnMGgZH01xwOrgZj+lge1lHeJo8lBCN2O8zWWm3OIyjdJRXEfvLAIBxJs9hl
         1F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0ex9MtTWbw5+Te7C09q3bE5eh0O+MaIkl3zChMf9VwU=;
        b=b4NmGA4x2f4dIGZYHqcLsj9taPRFfwBfkDux1XKCKQ2hJVH7IYtuFh6Wh9a5wr7FDU
         nfQenpteoUAj7cKaflEI4ViEIzsf4VsHwyoFiA98ne+uA+YOCb0k6o5Z93HbWhuBfKEW
         TdAGHsW1KliYrzYlbyxOgh5mJfpJdUi8uqtfGyEatLlhIAEod5o5RNMQ2QGSx0MMNL0r
         NRyZMllny2+GDqeOUy8WdAWAYwtEAXAZ5FXoOx9mSVG3k/ECjKZuzZ8JYKPPxyGjmTDt
         ELUKWIOWhuKkspe2yIL7q7qXjvPAxgLv95SAisVJ+PW1QmbfLiIul51qbTZTfWnovZu5
         IXGw==
X-Gm-Message-State: APjAAAVE3GqjOYJangPmOzvVz8WqHMAtT7hOrhhQgcuKx5zjtpuZ83N8
        7T4a7PdFC1wsfb/ZXBpJagqIEjiRGPy2IykVCCGU+g==
X-Google-Smtp-Source: APXvYqwRZwZCSWMKa2N+vyaSBuC8TiiyzNreqB4z4t9CaxSaBdj3PNkaRc90NngfFcPLoI0ihB460xRfCABamHWVKvo=
X-Received: by 2002:a5d:4f04:: with SMTP id c4mr12858831wru.373.1572240413295;
 Sun, 27 Oct 2019 22:26:53 -0700 (PDT)
MIME-Version: 1.0
From:   Naruto Nguyen <narutonguyen2018@gmail.com>
Date:   Mon, 28 Oct 2019 12:25:24 +0700
Message-ID: <CANpxKHHAngJWaW0uiOfUnBCi2Tv36h33dVg8pAuAmMcbnYzzJQ@mail.gmail.com>
Subject: NFS latency and throughput minimum requirement
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi everyone,

Could you please advice me how to identify the minimum NFS requirement
of latency and throughput on a specific system? I have some test cases
to test performance of NFS and tune the system to have better NFS
performance but I do not know how good or bad with my
measurement/result.

Thanks,
Brs,
Naruto
