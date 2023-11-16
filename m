Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50717EE8C2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 22:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKPV1L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 16:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPV1K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 16:27:10 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52936181
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 13:27:07 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1f060e059a3so707825fac.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700170026; x=1700774826; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S3SgYthPN37HAFvjMCYgaLv9Pu+Uja2vjl5XgKK9Sw=;
        b=aaQOuEhi62O78fzcIv0fconnCXw2jRgTH8eHZUTRDm4rgTE4B2eiuSciaT3MAqYstQ
         pvqTJXE/weFqtjJVKCkexEYoyDwbFS20YSMkCWnIeAxMNuA0ax2364Y4uLSId7Ny6tuj
         CRGvCWZFhw8S41SlCIH1QGNNuQ8FIbVFPJBMuXFpWoXgMISl4aACCBe7fcGAJYLIF4qq
         7a4aBOD3ajv3TPnpgE8sgonE8nRhpSpTn5+9zPqlRpG6tSNm4US8K/nP3cY093ZFbKNd
         lpu7xEmdxz0R4MQmHhZdodFHpfq5LXRtBB9gKgLAqZm5eTGteZKus7AzDzL1vUI1IgzD
         SmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700170026; x=1700774826;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S3SgYthPN37HAFvjMCYgaLv9Pu+Uja2vjl5XgKK9Sw=;
        b=DbBpfWAEkCSXag9iq80JRk8bWRXS2tlwm9bMa/jAQM7iJxLckqk+gnc4e6Kgk5g5hE
         CxgdFiQnfmSW4+T2nrEVq1N0zL7BW9RrBN8aa/cp5cMcRxP7l00JiDFvBToWeNZ42oPd
         DfAinpDQAz8gnucm9nCafrHRl7lFN3BnWrNl39WPOSMnQrgX32APTzqyx6G09O9Vsqrm
         L8W+tewA+sb17Rl42070++nGzxSSl36FoBf6oZ667R7Ld0gOGhaEG+Bl8mVXg1XxsKRH
         9YXfkRs28gDIKPu84UL4ChnAURNnvS7VAYILT0ToTGHQTYvu21qBa6TSep+pG3Fu28zO
         zH1Q==
X-Gm-Message-State: AOJu0Yz8dS+7vH2cv+cv/CaJx80AOQUK+18E3bIiEXOSpcUxTbXGfMoW
        gvZpmWaQYLKGyLrU/s/2B7XB5qtkp0DosmXITuNWZV6a
X-Google-Smtp-Source: AGHT+IGrKr8GQJ2t0iX7PTbTobIzBWoEWAe9qvQf9XJsIZrmE5sOZH9clTEfsHgbuOJvFUWI1IJNuOR72AREv9eFBGE=
X-Received: by 2002:a05:6871:328c:b0:1ef:f14e:6f4c with SMTP id
 mp12-20020a056871328c00b001eff14e6f4cmr23467127oac.2.1700170026449; Thu, 16
 Nov 2023 13:27:06 -0800 (PST)
MIME-Version: 1.0
References: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
 <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com> <761568108.788363.1700121338355.JavaMail.zimbra@desy.de>
In-Reply-To: <761568108.788363.1700121338355.JavaMail.zimbra@desy.de>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Thu, 16 Nov 2023 22:26:55 +0100
Message-ID: <CANH4o6MbXf1vehqa4VSUc6VhJbb_pVH71M+ovFSWV7kz4j0Pmw@mail.gmail.com>
Subject: Re: Filesystem test suite for NFSv4?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 16, 2023 at 8:55=E2=80=AFAM Mkrtchyan, Tigran
<tigran.mkrtchyan@desy.de> wrote:
>
>
> What do you want to test?

Filesystem tests, from POSIX layer. open(), close(), mmap(), write(),
read(), SEEK_HOLE, SEEK_DATA

> Protocol-level test can be performed with pynfs:
>
> https://git.linux-nfs.org/?p=3Dcdmackay/pynfs.git;a=3Dsummary
>
> IO bandwidth and latency tests can be performed ior or fio.

Is this a test for the NFS server, or NFS client?

Thanks,
Martin
