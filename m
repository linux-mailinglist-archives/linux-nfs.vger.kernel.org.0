Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0132654BFC
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Dec 2022 05:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiLWEl3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 23:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWEl2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 23:41:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9971DDC4;
        Thu, 22 Dec 2022 20:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671770479; bh=8xJvjaaLHWNgTOeVRgTfHiLjpBNn7m7oro3gPgWODFk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=P3c0a184j2XBfpKI+cRBPGRmo1OVeb2GHPpI/qvP3NrYijFHwO7qttobMiIGKzZnO
         qCxiccmBTBc11+qiIyHyMtiA3pIV3JKXyyZu4i0+SfL4/BEgDRn0CfKYMoqhr6dcYv
         DxerLja51+JkBbfrKeBwF2x4seWzk2MqYEYYSKOZHbOJ6of6OqTV2ThLYIU11149ig
         gKP4/74xlrKeNqZqDBMWCHxSAEjuxPDVmeItiXwPUsQBr/CWH1ABFWI8rFd62I5lS+
         pYYnWsfFpU7QpYSQJXqlzjWmlopABwUWptt8TOyF2T9KT+4vBaerqG9HkwhQ/kBsCe
         4GzZW1Vx6PtPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from bart.fritz.box ([212.114.172.145]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1oTyFn0BZE-00nlI4; Fri, 23
 Dec 2022 05:41:19 +0100
Message-ID: <a0abf7fef412dc0de0e42cbcd75ee5dec28cb544.camel@gmx.de>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 23 Dec 2022 05:41:18 +0100
In-Reply-To: <AF3DFAF9-CF19-40AE-8B8F-31D100E00F33@oracle.com>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
         <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
         <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
         <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
         <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
         <36902a3dd6ee1a8656548ff5b5eadb88245e2799.camel@gmx.de>
         <e51b8b218f18abe00ec76eb911d5b5b5af02f79b.camel@gmx.de>
         <AF3DFAF9-CF19-40AE-8B8F-31D100E00F33@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WTqLR7XWHd4MZMjIV+HOZK+pU6vZIOi6fxnZNY3c8zS72Z7vlDj
 5XVImZHTdlu5f7g4YByKTUHXt1rqRsVVrOKqHV+sJvqt1CIgWoxf/EHwWz3DHOS0LmGjAmH
 sdZbAaFQUKSNCMaq2OntKT2/GIIoKySAwIrLPSinhMQXLdQBFWG2RL2oiRblfAKh4hzpafz
 aMIcfA4CgW8j9VCMTqHzA==
UI-OutboundReport: notjunk:1;M01:P0:pVpPkm/1hA0=;nkBCxSeaz6P6LfofDka7OeTBiHE
 Lf0XCYSdHHlc+WFMsTuX9E1ZAsEOF5hZbPBb4oC/n5YmN42lY/1mvLbC0nO/YubYFViGXMpvJ
 sdjxuXnHxtuurD9baw7mRfehUfVmU9eFG8felhyg+eIm43YeUPu9xKbU9PhCnCYqMlMEpMXut
 1j3xgHigddv8eccgLqA/g7TMkfRl9R2pXXOEmfYgo/TtUlfDXEiLWTsprXvXNd5M/CSIWfxNC
 +808aVz6aol8Yi0FVOTFp+x9pMhm8FbW70qv7CeQs+2qWLygsXHSlbdXGnJA87WgfQQmleMFa
 MEtQ6uMdZsF4ccQnaXDvkn2Fv0fu7vcKNd2zxzdiQFuzobhn6g8rdOquwHhcUiRTtZMiAiwCC
 Gm2cWyfAm2xtVyOjav1csS2gaXpROFDThe+uHw8Zjlx2WhUQEDMjqch7AB45G9zmKXrCdBJiO
 Did5ay2N+fmFnSgQEz2Jlec0QbCFjElh/yUhspO/yE1lskL6M0uAjcx4s+vflkYtql5WRfT6i
 jNxt5MdeLrGDx8CxdPYLJnw8PwSqz2sjqlfIo3MjfZCV0TdX+VNx7JOvgSaHKfxO5gIDPOshb
 hk1L1RoftB7I0otubxDRXGOxPECz8bcSQdQ/bIKU8/nBreYIxWbVn4TEEfE2wusTyy38cquw0
 il+/mK0HIfun4o6EEw1IkqS+lxD/KiCaMWVIITLeefhIwfEWli76owolUsE0+7IcfAF/F/rJj
 jEFOPY3l5IJWRyddrdlVHprCnwEw72WOaz3T1gh2CvCB6JCwA03C5nlls2gaQNv4siI4ZgdtY
 gRQth0vgnvkEVh/VMr6Y6kzqlGOv/eAbr4+c7qqPZu9P6pN7mUgIxvgCqbRxFgtuHopLGiQB8
 hgtu5WAJqRLJtTuECDaVrdFE49mO/C/UX7eG6yPp91oghaebTrRzMXlGTRVXyBomiWYMyjIOC
 ZPuW+iSUfV2fmUuuPwbM9vIdb6U=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-12-22 at 14:21 +0000, Chuck Lever III wrote:
>
> So my question is whether you see a problem when only a1049eb47f20
> is applied, or only when all three are applied?

Seemingly the latter.

	-Mike
