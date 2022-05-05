Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D3551B77A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 May 2022 07:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbiEEFfA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 May 2022 01:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbiEEFe7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 May 2022 01:34:59 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-oln040092066103.outbound.protection.outlook.com [40.92.66.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E1B20F40
        for <linux-nfs@vger.kernel.org>; Wed,  4 May 2022 22:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uowqyc9RZ3ckDEyhSxAaU8S8dokW0Bn4GyScPONBLEcIwvxu6rjf6xYUOfLiCP4oBwfTFHQnCoOg57zS43YnVhYAg7Oq3jGNRQz7OY0wDB3Q9k4z6zZu4al41Ic0BAbjAjAn+BPCsnCifCNd4i810p26NYTLmNNDQ0loKDT8mxofu5xgavtCILSmesMk6GkEyuUnzOzkLnzoJoW6lGsyOfZfv0S1uvZbV17RNoQsb8aYvdGpfnDujYr0PFMNUYNwLFvzd3tCrG588cZANHZm5g2SMI8dhyUJpWU5BohjjdBF0wbxmZFE3TVFbHMfQFe+TNTVH43vSvB0TnxlBqXCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmTkirMjmQ+fFpkmWOiiHzVuH9EvDzcD5MdT4YRrJME=;
 b=OZV4JOxmLL0rb83jWGx/6Hw7RO25O0L64kz18twk7QYXEWZaWbiUZMOiiqSXOxNiDv0lKPsia8jZak1Kt0WelgL5yNCMdE2VenoYv5eS0xYcXUvpoXyfhGx+VfUuD9f7Cz0/mhCYsAD9vbVq8leNz52OVMNW2iShcvMEmTqdePfO40zcZC+6cMhG2jUfFgSDK1bm0pGAMwhCpOSSfziVxLk0K60fR6ZN43tAJewGO5B/F+RLxkR59CC8w/41Jcs4/rY2LGe7fyua1slPBKJTILWpXL9nxSRlZtBs3BBnChJe81xotCXDxu0pfbdVzKDrIO8k4n0X79SPVr3C1MGmYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmTkirMjmQ+fFpkmWOiiHzVuH9EvDzcD5MdT4YRrJME=;
 b=HlgehKlxGhMriJnxVDwVLblhXcPvEKzbYsZho+I+k9qdvK3Q0Rsep1VJJQxrcndju5vhuime3LgRQ50vypIVpzCjMMEu32VLeIF4tTYwtcCsgwXQwePy61TQxggvS7qCI1HfvcojSiE9oVNelaMfkRDtv/FBElzZomuaI5jJD3YaSrrtuE93cIlyk+cPIr1MI37tHu5lAWHvFNyCD9CSJiQFbgAtV+o8WhveBcm2UMqQ5XP6bER0EYXbK8gKqB6Pb0lRfqcU5N6EJGDbhGHrv3aBEppIHyd/KrbMaIukCafHe0oPwioPvIWrb8ntdqFkKRTyMMUr6UTtseWYmrYZHw==
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:267::24)
 by DBAP191MB1195.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 05:31:11 +0000
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a]) by AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 05:31:11 +0000
From:   "andreas-nagy@outlook.com" <andreas-nagy@outlook.com>
To:     "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Rick Macklem <rmacklem@uoguelph.ca>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Chuck Lever III <chuck.lever@oracle.com>
Subject: AW: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIABBqgAgACBbBKAAqD3gIAAWlqFgAABfw+AAMzyz4AC9oCjgAyG2mA=
Date:   Thu, 5 May 2022 05:31:11 +0000
Message-ID: <AM9P191MB1665FA51F62F82B006FD97168EC29@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220422151534.GA29913@fieldses.org>
 <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220424150725.GA31051@fieldses.org>
 <YT2PR01MB9730508253381560F79E96C1DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <YT2PR01MB97305156E841831C4093CEF4DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <AM9P191MB166535ACBCF1C301EF900A858EF89@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB166592CDF7C78BD68CC153498EFA9@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB166592CDF7C78BD68CC153498EFA9@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 4081e70c-f380-c418-c794-62b61e9cf0d5
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/K53U4rBLRd+6WtdFHfoJDR8qqUqE6S5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea2c1732-0385-4855-a31e-08da2e58773e
x-ms-traffictypediagnostic: DBAP191MB1195:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+lp2ffT42MRYix3flpOwm7WHA0MB+nb2ibAYXThtB01wL+PLZzG82dFA6208kq/LdoyhABKkIc0kg97oIFSSSBdThLoeeAQDlAVdmMdfe2ifDWDwfeuZ1N3emkglhTSwzCiPOXThYcQ+61TtSj9FV3GNWhTTcc6neheecob/FOMq6nPxaOH8qZNUBHsoRPtsmXWeF+u03ZANekzoA72GVVbDEoyfIL4HChOe8Rrvv3+NN0kIuluLv0RmDrs6uIVe9f+WTVE8uB0gBGEnC+sC8U5kap/kN/ft0/aCBlFz+TrEulRaQCeLjqykKpv8myKUKwqVoKIuNPb/fHRSTzBQdmlBUXkfAbPSe/apKouWYrExd6kv0+BV9ZBBP/teZGoSMmULzP1nnp0q/PuX1U/HJWTynjxYVp6PUYhGh11qYl5vzMfoqljivF4nZpjhVuVmPMlgeD5GTAoMvVbarazKaJvpEJevKssvnzXc7CU3f+may5rn8V2UqOcY1lVxuQzVVR6/G2nEyAOPOV7NjhmSqncDkvTmT3a49Vhyh3f/9V3+HJODin9cbwpsyObaY386rfW3y8hJFfqzfeeX0wL8XCZC5B9XIU6OprjoBlsmOKnQh5XfSDrLcdAzY3G9c3RmC+MLOK4kggpVodirgj8va/CHqPUqPRoyOutdsTHRQ5yQlQx/shy8fuLMpeWPu28
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YllD4y5nBkn9F78wwrKhurbARnd+X4uj2jbpM7GpKjVHKo0TfQOo/7dkqs?=
 =?iso-8859-1?Q?PksuxxZZ4bAvv0/H3q8mHj+C8P02pvImrv7/OrAArFX+AFXHDgcsTX95hE?=
 =?iso-8859-1?Q?2Ei5lt3wy6/1Ki50Z1c2Ch3sM54d90vKZfNFfGdwAsStnQwnFN35md52V2?=
 =?iso-8859-1?Q?3+pnmoSjMeSeDfP8+ad0dNBs0YmFn0N4dEGZWGjf2fx+E7goCm7oMpompW?=
 =?iso-8859-1?Q?o+ICvLrAO2QlF2YzbTR6AUv+50AaHJEVBPYyk3uL8I2EYxVLmj0b9sIKsH?=
 =?iso-8859-1?Q?sJKxmTYj+2G1WBMfbEG53K0bNeDB+t1DpHoRq1p4zqAZ74ux3EbIIfTzIn?=
 =?iso-8859-1?Q?DJ0+n8U5m9lX+4fBZH6Uy6usjQrSL+i7Woxf1ZatmnYKDu1vgHIixaTSyv?=
 =?iso-8859-1?Q?+RjBJHfNQlBLyglLXEGRDpf3j/OBM1tWpWfKpwYsNz+ZopR0pmAMlFlpsl?=
 =?iso-8859-1?Q?ZG1IHIrzsEmhOSpgzY/lfxg+FR6V3/4h8x7MKlmAGCqtk84X04yOlW/Qf3?=
 =?iso-8859-1?Q?upqmstgwCR+FWj1jNdVpYY8r8KYHT5FLTE0koVzdiIuMYsqTLXLLOZZcqC?=
 =?iso-8859-1?Q?V6gpl6fdpOaOoDWtFJVA3zC4uCfX2JMaGkHRk5Ug80dyT8faZqAjHiJCjq?=
 =?iso-8859-1?Q?wiDYlFaIWMomCFjjmHOZGmC+F8zw/XTu+0NbDmlbBCRgzSDOzttB7lxZ+6?=
 =?iso-8859-1?Q?SusEux8uUmDzLmk/sKT1X81gs6IiJvcLBrmUt6uvUL89a/m8raJYlr3uyo?=
 =?iso-8859-1?Q?HPHimzo3Z43m/Pdyr0WKizrHnj2NFf8Lqzp6vQUMQdTin6zjlRdGsA0TcB?=
 =?iso-8859-1?Q?o/FVQts9ESkooqeiC6hP1sepNsZNXwaHW8KuNP0VUFHQ8BcDfOkASE8HHr?=
 =?iso-8859-1?Q?sUbygowS7dCxlqqR55xp2+Nvy5AoECO2iM+sYi0HpwN6nXjZO1EZ5sI6vU?=
 =?iso-8859-1?Q?tPtLk2WoPp+rBp+cUUWqjNG9COabGSO+OFFURNEB1Ct53pY4iPxVqXTaSX?=
 =?iso-8859-1?Q?LmHGIoH9Ov4WJ98hP5OFZngTEdgQqhh8rv0vnVTjZpq69CnqnhrvE7oxr/?=
 =?iso-8859-1?Q?aR6pftJxM6EJ3S/K0HMkK4KajSniT06VXrF543QkMOTckuSEm8jUHPwFir?=
 =?iso-8859-1?Q?DyXrBay9NFs48PZAbzJTCx9U05Zfp3lFrdcQyHhBEKhlLDdFBKFVQonH8u?=
 =?iso-8859-1?Q?PYtdYgdwJLEzR81AYzTMalZys4ihmCoo5m1heZ2WaM6TE8IvdPFC2M2j/y?=
 =?iso-8859-1?Q?BQIJXksUt/zMLzOgtSU2vS7PbajuOgCHGhLyC2EEW1L8rcpa3b9FtPzDJM?=
 =?iso-8859-1?Q?NNHr41vu/m46SGwQuLssKhYhj25ojics6mUIap6JmU1hRF7N1KqCmx2TTD?=
 =?iso-8859-1?Q?isQ6cW4n7eeE4Ouwn7QauafvR9uu0ET3JgHIiA450Rb5oc5AqOZDt2DuiQ?=
 =?iso-8859-1?Q?eRqcFxNRMbXaUYga6fC4cqDiMs7d8wS1xyBCUwaSpIfbeEtFqPrd8Tx+c4?=
 =?iso-8859-1?Q?g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2c1732-0385-4855-a31e-08da2e58773e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 05:31:11.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP191MB1195
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,=0A=
=0A=
was someone able to check the NFS3 vs NFS4.1 traces (https://easyupload.io/=
7bt624)? I was due to quarantine I was so far not able to test it against F=
reeBSD.=0A=
=0A=
Would it maybe make any difference updating the Ubuntu based Linux kernel f=
rom 5.13 to 5.15?=0A=
=0A=
Br=0A=
Andreas=0A=
=0A=
=0A=
=0A=
=0A=
Von: crispyduck@outlook.at <crispyduck@outlook.at>=0A=
Gesendet: Mittwoch, 27. April 2022 08:08=0A=
An: Rick Macklem <rmacklem@uoguelph.ca>; J. Bruce Fields <bfields@fieldses.=
org>; linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
Cc: Chuck Lever III <chuck.lever@oracle.com>=0A=
Betreff: AW: Problems with NFS4.1 on ESXi =0A=
=A0=0A=
I tried again to reproduce the "sometimes working" case, but at the moment =
it always fails. No Idea why it in the past sometimes worked.=A0=0A=
Why are this much lookups in the trace? Dont see this on other NFS clients.=
=0A=
=A0=0A=
The traces with nfs3 where it works and nfs41 where it always fails are her=
e:=0A=
https://easyupload.io/7bt624=0A=
=0A=
Both from mount till start of vm import (testvm).=0A=
=0A=
exportfs -v:=0A=
/zfstank/sto1/ds110=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<world>(async,wdelay,hide,crossmnt,no_subtr=
ee_check,fsid=3D74345722,mountpoint,sec=3Dsys,rw,secure,no_root_squash,no_a=
ll_squash)=0A=
=0A=
=0A=
I hope I can also do some tests against a FreeBSD server end of the week.=
=0A=
=0A=
regards,=0A=
Andreas=0A=
=0A=
=0A=
=0A=
Von: Rick Macklem <rmacklem@uoguelph.ca>=0A=
Gesendet: Sonntag, 24. April 2022 22:39=0A=
An: J. Bruce Fields <bfields@fieldses.org>=0A=
Cc: crispyduck@outlook.at <crispyduck@outlook.at>; Chuck Lever III <chuck.l=
ever@oracle.com>; Linux NFS Mailing List <linux-nfs@vger.kernel.org>=0A=
Betreff: Re: Problems with NFS4.1 on ESXi =0A=
=A0=0A=
Rick Macklem <rmacklem@uoguelph.ca> wrote:=0A=
[stuff snipped]=0A=
> In FreeBSD, it actually hangs onto the parent's FH (verbatim), but mostly=
=0A=
> so it can do Open/Claim_NULLs for it. There is nothing in FreeBSD that=0A=
> tries to subvert FH guessing.=0A=
Oops, this is client side, not server side. (I forgot which hat I was weari=
ng;-)=0A=
The FreeBSD server does not keep track of parents.=0A=
=0A=
rick=0A=
=0A=
--b.=
