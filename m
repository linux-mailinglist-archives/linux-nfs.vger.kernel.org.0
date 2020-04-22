Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69DA1B352B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2020 04:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDVCua (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Apr 2020 22:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgDVCua (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Apr 2020 22:50:30 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443C4C0610D6
        for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2020 19:50:30 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id k133so621728oih.12
        for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2020 19:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hf5CAkEGNX7PpP0KMAFbCxGOsEhCF2uAt32uVRcPgo0=;
        b=OMborahwJ0E1KpKW7OKoYCS0KA1S8NcRZzxfNSXsIXkOr+VoAeNUizvfCDxuVS7IxY
         EkmwyctZDj14/NStrPUuapRkc/nKIqZZ/2QjPicMc+tXpiyX5imv7RdgOFAJkASsijpi
         +UfvBROETVr/881DyIgMC4B//j2T0oTJDSfT+EhE0dEhcbJHWEHlo3Jhzuax9YAdxAVr
         5smcjt07WTyCAzIZPQCtkNCAdbarAszQHSQ5WnOVp623nCIkA4Sg+aoNhu8qETsNhUAh
         29iZCerSiftdm2bxymT9DCwzSuhQaXS6fhrZ4nsy/1eSoz+fEvjA15aiIKx4f+/QmsNm
         /BBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hf5CAkEGNX7PpP0KMAFbCxGOsEhCF2uAt32uVRcPgo0=;
        b=BDBv742lkZI9jMOULUXc1IMBs3mK3BL9nA+Pc/akFNrj6osjD8eNWs2mOPfo9WnNcx
         jvm+wIdtfHAbHuiwtRLqhu1RghRsRiYo6av70sjtUi7Pf2hm9ny5DIQszkPHNXD3FYGS
         mTLH4hsDWGBA0XxuZ/QfbRwefexKRDs7xPTBoyGK0GYn9xBihHnpxxMlaQiZ6+tQH+dg
         F9cAewBbI7ecZo6bLldqmf8VgwIKkcwlweSVWWzBlqDEveCIQ7LMJyf9Ee4kUcNl2DMX
         HXOL12+xkLBrNbvuK5vdqkTY/Q4T4Z1R8y6MrlDicGQpVDC50+dCL1CaaMjUXF6Nzx62
         plOA==
X-Gm-Message-State: AGi0PubmPaEbDtG++a11vBLNeT3LnlRVa+UPUpMtcHA3rTlFo3JEQyYH
        s9W5EKKkWLXbUejkJntDEO3YLvIduyX3v+mK4IUFhwksjcQ=
X-Google-Smtp-Source: APiQypLzO7iqE7s0r+XqeeCHm6aORhWUl8GKFTgLlzytVSPvybwntP6oxkom2Hh0B4ixhffXsLW90j/gTJ/BBpuou0c=
X-Received: by 2002:aca:4542:: with SMTP id s63mr5220910oia.84.1587523829656;
 Tue, 21 Apr 2020 19:50:29 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>
Date:   Wed, 22 Apr 2020 10:50:20 +0800
Message-ID: <CANTwqXDJi1LuT1Q382R6qFHm7qMqx6My6aCR0pejNR8BqzFLKg@mail.gmail.com>
Subject: [BUG] fs: nsf: does there exist a memleak in function nfs4_run_open_task?
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, all:
When reviewing the code of  nfs4_run_open_task, if the rpc_task start
failed, the opendata reference held from kref_get would not be
released even return to upper callers.
I'm wonder that does  there leak the opendata?

static int nfs4_run_open_task(struct nfs4_opendata *data, int isrecover)
{
      ...
      struct rpc_task_setup task_setup_data = {
      ...
.     callback_ops = &nfs4_open_ops,
.     callback_data = data,
      ...
      };
      int status;

      nfs4_init_sequence(&o_arg->seq_args, &o_res->seq_res, 1);
      kref_get(&data->kref);
      ...

     task = rpc_run_task(&task_setup_data);
     if (IS_ERR(task))
            return PTR_ERR(task);
     status = rpc_wait_for_completion_task(task);
    if (status != 0) {
           data->cancelled = true;
           smp_wmb();
     } else
          status = data->rpc_status;
     rpc_put_task(task);

     return status;
}

Best regards,

Lin Yi
