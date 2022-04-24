Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9FD50D517
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Apr 2022 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiDXUjN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Apr 2022 16:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiDXUjM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Apr 2022 16:39:12 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2058.outbound.protection.outlook.com [40.107.115.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E2C156E2B
        for <linux-nfs@vger.kernel.org>; Sun, 24 Apr 2022 13:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIW5deVKIL1jA3BbaH0IXsL37lgNovdxMMW9hQcIave8+tZJ7jn/wY9MCkInsaE8+58RtKxg6/Tgnb7BEyzINenSRVJf/kAGifPMR6o0UT6usrH5/bWC3TkHKDmfNzDeIMgWqyHBCHYRI/ogsuWijtxnAa7Jp/1cKnK1kNehA6KMPsRTLn77Men2t1wsAvMKIC2c8hEp/t2yPYk3/AnkuIY2xbhSMgbebrlvc89xnZ1EHhN0aQpBcqQ9yosqWG2aN20NVtTiO87SQE50LuQ33eRh3ET4rCO3nsUdCgbt95GFEuI/TqwooKnkwlCz4V/078IkbtRkq+YM22XXRpdAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSUkqD/H64oz60Lp48YKuZ15iMJbLp+0N9T6pU9QAQQ=;
 b=SQwGWIjONd5B3ygp8kYgh6/ShSG95sA6PPAXXlqUOd4wzI72PaFkws3Dv6SetqgiBEs9C95HBRole4vqB5uSIA4ZgPS2vhSvFGEwQKhPk5bZQC39fCD7pm66AJJ+kiLm0jXwYc2mB+6wXESwnRfnCM04lyGxy3NK3Izo4QLWKzAgrBk+Y0/mk6x8SMYaTdOgyNmnhvUqG6dA+vsFyfMu76+8EYM4F1ZEP841RAQH35bzIVp68Cbt5Uqqb1/gKJH0jn6Dn7kIN9TbPlXIsyFLi/MZwfbI6NKOZJYiM9ZxEa7g++kibz5IKOedvCOB9ctcWY+I4CVkbzbR+h4R5wCxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSUkqD/H64oz60Lp48YKuZ15iMJbLp+0N9T6pU9QAQQ=;
 b=Q1CjUmV9nZP6rxRZpRs/kGZTQ1+FmO7sMkrpenPpDIpMZ2HMwV7PLSo9i84/xFwBwLTZulYF0B9xQDo1MHf5WCTI0jh2lMkoSYf0yZHjzzhMCVm0P4x1O5QuJEUyLsUI4RJsWwRNuMZRIjor5AxmW3Mdit8Yt/K6pM6XfnShXikcpOdwtroqBZbAmnN4nDVrreLys9J4MRE6yoFhDkaXDYbTWKU8+8gapHIBTpbkr2o4zYJSJ5fjctENjL7b7DdL3o+fXRwRTkba24YwfaUUJCCDFAz+n1zID+9f+KNmjD+jTZvfXmjjmo1B+SkdId6wSxqDHTZKXK45yKM6DOB2yQ==
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::14)
 by YT3PR01MB9930.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sun, 24 Apr
 2022 20:36:03 +0000
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003]) by YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003%6]) with mapi id 15.20.5186.021; Sun, 24 Apr 2022
 20:36:03 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIABBqgAgACBbBKAAqD3gIAAWlqF
Date:   Sun, 24 Apr 2022 20:36:03 +0000
Message-ID: <YT2PR01MB9730508253381560F79E96C1DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220422151534.GA29913@fieldses.org>
 <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220424150725.GA31051@fieldses.org>
In-Reply-To: <20220424150725.GA31051@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: b65541b4-0644-d872-ef9f-dddf74b91f34
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f319bc9-dac2-4f8c-d4e0-08da26320ccf
x-ms-traffictypediagnostic: YT3PR01MB9930:EE_
x-microsoft-antispam-prvs: <YT3PR01MB9930C4FD02A7A83B999ED5EEDDF99@YT3PR01MB9930.CANPRD01.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1Rxg1y4bOKlpf2rpEFZg6Tu2tfthmh1dZLAAyoo6v4ZcX2EJIxrMt74PriQexdvbHEPMJAo9NRTTWdc1mIosaYs53GiQpvPLwVcfK+/fYwSOFuAQqsB+ktHRkAVklOIZu89N+VO9yNhECJpsHgjTdJR8MF4qq5knqWeUmQnZxxsiEAnbozsJ7n+fdEcmHVZPAXEcgPPRKW4CbJhzfSDcC7zlTVCPiaP/XKZqzSa/cJSGJBpSWiI0A9L5ZAgvool6sTnz3DZ1yUtf6wEvz/mEj3be1m04abHzVsO14kyyOitK2xNjL9dyHQ+VCji6cxnQhgc/OwEEK4NOCQhMwi5Q1+d1sG+C1SkLY+4oHTd0ixiP+jLB4cmNXhoujAYP2ZNACnU4FpI9qD7WSRMlZnqCCflyEwzYCxjFay0c7m/I6mPjIFK501+L2CfrcXld3vDxokQ2wBT58vmKqdDXY+xBaH3kDztzHp+V/oI/9xeg3/D5VAJo9yXybLOgO/gVPgDgEOVjtQrBuARj9Z1XQJL3jLBsQjG0xZdj/E7dHKEF/zT3sbSnwzQ10QowmJ0rgJN1DZeaEruQmRS0HbILAlOsyP/E33cq+tJR7S8XEGFcKLM3nQFxwuqLu7wMk0NRiV3zjDZbkhT9DDK+Xq8cRwzeNpRkxYXxTT27vNmjzN7KjTQUGtddVwCabEe3iBn3BmDKaHqZ83/yqLVA/YkUk/3yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(64756008)(2906002)(66946007)(7696005)(316002)(4326008)(508600001)(86362001)(38070700005)(66446008)(6916009)(66476007)(52536014)(76116006)(6506007)(54906003)(38100700002)(122000001)(66556008)(91956017)(8676002)(186003)(83380400001)(8936002)(55016003)(33656002)(786003)(5660300002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ix4gddbdrKcjnxYs51yV4wyRcSTOiJb4M6mnYI0c5n8TfCv6UbFTaZKiCk?=
 =?iso-8859-1?Q?WK4TIU657+0gCPBbuqJ1/+n5EWS6GfApNFzvIH3+KzB0O3C8LLWdB9gmB6?=
 =?iso-8859-1?Q?/J+gZRvRMMk/E/vqW7vj+0GXUtVcmbdkz36Vdp2Ge4Rf2x0IWkYTRg8xRg?=
 =?iso-8859-1?Q?8zHrlRC21qWddBs1YYfMaAorOig6RlwHdfj/pCXRNe5D8PVgs+MAe3g2it?=
 =?iso-8859-1?Q?zAym+PoiSEDu9euk1M0imvJaQYUsTbYJZ2X26mV8u/3raS3Wb0KgVJR/cl?=
 =?iso-8859-1?Q?vAWqQl2FpQczJiYxaxgA917N0y49dRMWAUnQbFf/vDWXkDsa/VBaVLWGJV?=
 =?iso-8859-1?Q?lQpOTe6p3Lss1hrarUu4YBeWzD15b836x7gxp8wbU0tiApuEglobos0VnV?=
 =?iso-8859-1?Q?toNBm6HwyOBDtITHnWx2x+LrfH255dhQ2OH5P5SIZs0ktDgfteT3U61tMG?=
 =?iso-8859-1?Q?hVIrxcL5TXZ04yFDZ1e5lyXMuO0bsesTqAoqbqK/e0loQi076eCkjUYlsa?=
 =?iso-8859-1?Q?VZ3ropfGIDnv9uYiCJhT64patPPgThIHXPCQTF+951tMEJIvL3oqRNxoHx?=
 =?iso-8859-1?Q?qrEdcnM4k/qfyEmEbmzpjFbeK3TREOjJFsOzfSQXodbXEmgR0p3Rt4r60x?=
 =?iso-8859-1?Q?JUUKvXTvhuLu4o6rkd/9CbHVhlFGIdPsh7zkbAgtqwAxMFNVOBik87jUd8?=
 =?iso-8859-1?Q?+cOCg5fqwW7OKsjk0jy+MFtcjEhiF/2uXMQyc+PR6GdCquAoOxyYystvcg?=
 =?iso-8859-1?Q?+ULOY9RVOv/2ajgjCPQh+mSlmm6P39XN6taj1bK981jIIXUkkX6tEIRMp2?=
 =?iso-8859-1?Q?N3PrvO1/yWEE6pOgXoSiZfywWyc5oENHeflejmYqZ+9Yn3JU4AldttSQ3c?=
 =?iso-8859-1?Q?zHo0uecuVNnCA6+k6PraR13oyioxDTi/Nyf2632AiS9zGKdwfs92tsj5B4?=
 =?iso-8859-1?Q?MDhQfrkkJFhnFR+gvucsdbEl/hpfT+3WK5OW67u12GfcAqwAiRhTS5eICJ?=
 =?iso-8859-1?Q?m51n8yqxpmEE2tZt4L9RC+3WJcWxVcqkeW1/yudNMeolRXryAq6f2p34Tl?=
 =?iso-8859-1?Q?7IZG3ehVHjHpkSm6V9Kk5vj27kFE6Ap4+W2MBeHUQGXIcpbumBtWatXUs2?=
 =?iso-8859-1?Q?1GrjeLpbP5NsKcrRxb+/OzDli7pqbMwtxaQRp5Oq4RCtMHTLr+Pr1Fk9HB?=
 =?iso-8859-1?Q?0JUPGkHmJuHXI4B/pshIwUCQNDHtE2D7N9unVf8AFQ+dZd7J5zM5ZvWfnw?=
 =?iso-8859-1?Q?W6hTrFh+90gQXcJ0TXtY/0iFR6efm83BhUS1z8OeY26IoBII37Pa+kXoBt?=
 =?iso-8859-1?Q?03i4T6y6Qon6azWvma+6BLu/0M9JjPN0MB9lr+8pqtkcOAbNefFlKqb1C+?=
 =?iso-8859-1?Q?nWxDTtAgjZ+G5GDN6FcWLAaQ6VWIo4OfVVV1/VvsC7b9YsPp8duBLXCd15?=
 =?iso-8859-1?Q?qQ7fQ2uITjsvAPpFlS+6bwi7SEUajTewob+7gHyouCxly3i1+R+6dE+Pcw?=
 =?iso-8859-1?Q?SpKJBaOUPlUWjQxHSJ5sKVO9GhNVVzFwiJzRbENlBfbBa+z0L7IZkNP11v?=
 =?iso-8859-1?Q?HYKbwLok+/GoRnms4hzG/MItGO6T36/7Tekq+IH9E2Y1u42rUy7f9enHJT?=
 =?iso-8859-1?Q?i8PGASooagbnHGighEZ4EaOnXVoU/WX4yf62ByLW4M2N+e3A2665TR0NP8?=
 =?iso-8859-1?Q?HMgGHWpmeYZzX9W0SSaZL4lQ/X0Enm/ojnGi0/pBfJ5OCH5i/sNa4YNITr?=
 =?iso-8859-1?Q?osVOZs/jqVS1l13FeoVMcHN45CrqAtYfF4PSo1rR7uuCxZfHLCvszrOTen?=
 =?iso-8859-1?Q?w2Fuuey16crtgLIIYK9tbUrahaskmYXdAbK/WoqXvFm9xssELUpTnZaQEj?=
 =?iso-8859-1?Q?f/?=
x-ms-exchange-antispam-messagedata-1: WxTRYC+pYhuZ5g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f319bc9-dac2-4f8c-d4e0-08da26320ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 20:36:03.1357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYP7rSN5V8FJyQrtqq7v7izwAesrFD80UiOLsgMyW/vsF/4IlbySArdTwsrYm1WC2nO6EYlnn6oNVK2rnUX4gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9930
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

J. Bruce Fields <bfields@fieldses.org> wrote:=0A=
> On Fri, Apr 22, 2022 at 11:03:17PM +0000, Rick Macklem wrote:=0A=
> > J. Bruce Fields <bfields@fieldses.org> wrote:=0A=
> > > Actually (sorry I'm slow to understand this)--why would our 4.1 serve=
r=0A=
> > > ever be returning STALE on a close?  We normally hold a reference to =
the=0A=
> > > file.=0A=
> > Well, OPEN_RESULT_PRESERVE_UNLINKED is not set in the Open reply,=0A=
> > so even if it normally does so, it is not telling the ESXi client that =
it=0A=
> > will retain it.=0A=
>=0A=
> Yeah, we don't guarantee it, but I thought in this cases we did.  The=0A=
> object we use to represent the open stateid (indirectly) holds a=0A=
> reference on the inode that prevents it from being removed, so the=0A=
> filehandle lookup should still work.  If I had the time, I'd write an=0A=
> open-rename over-close test in pynfs and see if we could reproduce this,=
=0A=
> and if so see what's happening.=0A=
Then I guess the next question would be...=0A=
What happens to the file/open when the close never happens?=0A=
=0A=
Could that be causing problems for the client, since we know the Close=0A=
never happens?=0A=
=0A=
> > > Oh, wait, is subtree_check set on the export?  You don't want to do=
=0A=
> > > that.  (The freebsd server probably doesn't even give that as an=0A=
> > > option?)=0A=
> > Nope, Never heard of it.=0A=
> =0A=
> It adds a reference to the parent into the filehandle, so we can foil=0A=
> filehandle-guessing attacks on exports of subdirectories of filesystems.=
=0A=
> With the major drawback that it breaks on cross-directory rename, for=0A=
> example.  So it's not the default.=0A=
In FreeBSD, it actually hangs onto the parent's FH (verbatim), but mostly=
=0A=
so it can do Open/Claim_NULLs for it. There is nothing in FreeBSD that=0A=
tries to subvert FH guessing.=0A=
=0A=
rick=0A=
=0A=
--b.=0A=
=0A=
