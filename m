Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765864FC2BD
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Apr 2022 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348703AbiDKQyC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Apr 2022 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348701AbiDKQyB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Apr 2022 12:54:01 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF935AAD
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 09:51:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c199so9429654qkg.4
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=O/Y5K+CF+Mh7GvEdz3a3b9P6kegRmry3y3L/0YvGc2o=;
        b=UJ78C75LC6yWWBISL9bNGge8zIB5bEefv+jhAiMepnQ/broiM54lgW9PYjWE6kbkPh
         vIxwsXhiJ9zOzkdScwnwzYPwE2MPJw6jK9S+BoMYxgcKFLzRRAr05xN9h+mqKSGvqW8z
         t2Qm+SPjD6d82QdOBz3nKbMcW8QxrDo8lEB7yfHOyU7n9030dK0Mpl/fmi4BJ0FqhMcn
         TvL9VXttabRAE/rT1cdbCH7X3wze/Rpg+XB2UEn10Q7GdWR+a6bXRvbEDRsyDfqOs7oI
         /EbSNONktHTdbbwQHv2Y23tNVlCSi4ZZ2+MSG8yEQOPm/0phoIAd/l33/3kKXMjNhg1v
         VHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=O/Y5K+CF+Mh7GvEdz3a3b9P6kegRmry3y3L/0YvGc2o=;
        b=yDYOdzcv38za1LVXsbnZjRQIgJeOxbx6jNKeqYVoYP+PIfNpCuwjNreUyHqeU+nJ6a
         byasMM1CcoBOP/IXz6sgMRCuVVM5rejHsPI0b0JhMrB5/1OeH5qDitGyIgmUNwHEoncl
         4jeOS65HZG5C9ovWpv02jqnmYveHOHRVZu5Fqt3FBAwUJiDZ9CLfyPb6aOEbT297/4Dv
         to+rBlea6EcbfuYaaJ0MpJ1F1aU34IR1FVvlwj1Gx2Zp5AaWaW+ELHEyP+/ZWcNF29++
         m58BkPNIZhkxK5q2k3jJa4zrK0jZ9DewmPfFIywtC1l10EBUX/iENcoANzu65nSXvzK+
         IMqQ==
X-Gm-Message-State: AOAM532lG/6dOaNgCV87Tu9sx9Bf7NDdfDHim9ARE9ySt0llvGalhPxf
        vFU/0pKO80c7sJ7h4tcsHBQ+552iMns4GfdSY0o=
X-Google-Smtp-Source: ABdhPJzhHsXG81giU074lZu0K0OqXlQmWq65qRQ9nO/EQo2xbsmyB1heRbg/++6dQTogTwfCv3o755MBIBgnYDelEGM=
X-Received: by 2002:a05:620a:1726:b0:67e:d1d3:f26a with SMTP id
 az38-20020a05620a172600b0067ed1d3f26amr171122qkb.411.1649695905464; Mon, 11
 Apr 2022 09:51:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:190b:0:0:0:0 with HTTP; Mon, 11 Apr 2022 09:51:44
 -0700 (PDT)
Reply-To: dt91120002@hotmail.com
From:   DR DATI AMINO <dr9112000@gmail.com>
Date:   Mon, 11 Apr 2022 09:51:44 -0700
Message-ID: <CAE1eGCnqCQ2wCn8qkO=nGEF7BJ5Tjab-tTo+SVQJ12+ugwOx4g@mail.gmail.com>
Subject: Please Advise me......
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:735 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dr9112000[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dt91120002[at]hotmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dr9112000[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- 
Dear Sir/Madam,

I am making this contact as a consultant, I do have the mandate of a
private client with embattled political background offering a short time
loan for duration of 2yrs and above to any corporate /individuals under
strict anonymity.

If you are in need of a loan to fund a new or an existing businesses
requiring expansion, we would be delighted to work with you.

I look forward to your cooperation.

Best Regards

Dr Dati
