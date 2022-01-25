Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ADA49BCD5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 21:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiAYURX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 15:17:23 -0500
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:34656
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229540AbiAYURW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 Jan 2022 15:17:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrhDK5QMk4Xnrazd3PaBTVL/pBhnYyzYce+uK7aE+0cp5IZgizd1srEaIAFErZD9Jmt+D3dNiSJ/T+exrhqhiDawUE3HPwX134hRwlaU5IpCfBpUUwRMUTHtpE+8n6EIaIoam3XVTGJSsjI3/TgoBOM2jZ6umV2Gg2NOPQxeDTi1wvQufKblK2s6SzjeD+0b8lH3vogDqBjvqh1se2iIUPZmE8vjlojr14s23jjw4C0pCEZc0I7y1T9sO4L5So+8WzB9M+u7AJmK0wju4yohmWxXALDTWIBtdPQWy7D9l2PTCjqCYHwTqydHq/u0e6J/jXK9jtCmTOUjGPYJiyoDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3464V9B7Tld8auXUqyfqTK9GxHvV+X75/6W1yZalio4=;
 b=QONTP3GScGBXU++XPfeMC044TLtq2mcR6YWb6A/vLW0JgKW0UtswCducM0bieijaYNPcSDbAs061mBQKHnrWHdW2lypxZUy9f5h6RAkeFJpxz8sAj1/hg4829Cal6KEFkmAgfXexj4c2R6PaLD8RHP/KwLKh09pPbLILiHsTBrNxwT1rq8kYDrggrnJnb2OUJvzYHO3nCUsgT0EGNsu/W0elG3YnfCnfFKeAOOcjc6CIDGPgKzPy2vdsxqjc+uoF1k9+Cn1JtC4cZGWvJfjl/9OdS0RUIv1H+NAh97CooswzCg3MDVQEMMay5iMBwNqEyapEAeRVYpbqjJnVUn7u0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3464V9B7Tld8auXUqyfqTK9GxHvV+X75/6W1yZalio4=;
 b=pIUAU5R8vbnX1IMwBH/lgkdZVn4HV0g0ztTp+M9MOWYKHLx5MdGJUE3ROa+SBA1kpLLtSQP+245MfeKvJp4a58oylpeiTnqXiMyD/oeCw59aQCYLJg5JXfkxqWlIB3f+enPI5nZyz9H2HDF8jlPH0RH4jJbFuFXGuJ+sC53dlySLCfPC2Q5O0htXGPgvGZqbM8cc8BXkBiaCghWn7v4PeMkjcfW3vKI71R96EBhpjW1rUIPyZsPiG27DjxXd/ArQSn4efNLaeCfl0YVDw/3xy5MZeg6C6cIo5QIvWn9V4SZq0dWehTP0Q/08gUm7ia0iwRXsIs137DRbBDiP3ez6wA==
Received: from DM6PR06MB6026.namprd06.prod.outlook.com (2603:10b6:5:1af::12)
 by CO1PR06MB8171.namprd06.prod.outlook.com (2603:10b6:303:ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 20:17:20 +0000
Received: from DM6PR06MB6026.namprd06.prod.outlook.com
 ([fe80::bc64:1dac:860b:1e33]) by DM6PR06MB6026.namprd06.prod.outlook.com
 ([fe80::bc64:1dac:860b:1e33%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 20:17:20 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull NFS Client Updates for 5.17
Thread-Topic: [GIT PULL] Please pull NFS Client Updates for 5.17
Thread-Index: AQHYEhirrA6t7fQW5k6D/BNOVpqV9qx0K9X3
Date:   Tue, 25 Jan 2022 20:17:20 +0000
Message-ID: <DM6PR06MB6026834F259E3B09436286F3F85F9@DM6PR06MB6026.namprd06.prod.outlook.com>
References: <CAFX2Jf=8s+rrwgGxm1FsaPUvEHygLFaUCNeFh989v4MXmLJFSg@mail.gmail.com>
 <CAFX2JfmEBhRF63o8ZwuUjwJ7aOUJLb+h8oidrq8kVUsnsq5vcA@mail.gmail.com>
 <CAFX2Jfm=theSU4ey9hqBhAX5VEJe7p7QG1M7+946G96BqyOZng@mail.gmail.com>
 <CAADWXX-B6q-MA2FHuQvxrnEkbxsmQ+5miWtEr+yZhsyjuiF9ig@mail.gmail.com>
In-Reply-To: <CAADWXX-B6q-MA2FHuQvxrnEkbxsmQ+5miWtEr+yZhsyjuiF9ig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5239dd27-a5df-4a8d-fda6-08d9e03fb0c6
x-ms-traffictypediagnostic: CO1PR06MB8171:EE_
x-microsoft-antispam-prvs: <CO1PR06MB81714EA566584058970A83EFF85F9@CO1PR06MB8171.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /acuoOAWaVNZCvtNrGQU1Glr32TDNVbNkxbg1YOgl6d2/ZR8heGhrAYwLNIRX1mgfD7uK57Kmb30lxxk6La3WF36TB8Nj2jPHk/ES6sZhsuZGu0O94Jd0bGwwxjMIYA7fbVn2fnHzw4nVsfbjnZX2NFNrTe1gs157NVb2RosqQk1sE/mEIlDfRmROd+Dc9dCDFNcXrm9F/+lWcswW1wT9D4HHbKD7rUowWdJf7M74nWTuqGxfGKpF6KO+jb7Wc591nJuDe/isOncEOnlwq18AXT+JUF8k3SJLC2SEGUPWmtNndbI5o2Pim/JwtZuA0tepIn+iNpjswNKsgB+UfkOIWqXtHUYyHWvQEVdr/MzpLX/DW4S/XP8hpxmCncgo2+o/I4eorL6WrQkpUJhm2q+q11y1TBj5a0uKsQQCF0bggMzA8ZFXpKby3ukl3YNLlxuRiUXLyyE1MFmo2RCoVZHyPRL4mycWpZMdeWZhkPE5FXTaQmlyY2AAxvxu6s4X/kFSzVLqmHRB5HJerfkfl8AeFzWuF5bsFQJMe99HEmgq6adNrW0zf2wEkdhpYZf9m110PclsBSWZ+P7aXL1jI4/ePYWXQnMQ0ATPMQLu2Gq5LMciNnA3v7BrLg+ZTt15qtBJ/iCHJCsWSEjGDltk8xGqb2woVb488urFYI3Vf1de5k8/PBw4UjlP4kpYSu+BNEVphlv5YGxHr5N/jnmphY+rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB6026.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6506007)(66946007)(53546011)(122000001)(83380400001)(86362001)(38100700002)(71200400001)(55016003)(45080400002)(2906002)(508600001)(91956017)(66476007)(15650500001)(4326008)(7696005)(76116006)(64756008)(66446008)(186003)(52536014)(9686003)(6916009)(38070700005)(316002)(66556008)(8936002)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AVb2vQu0LQfjuLdgkhi7XaJy+vXLIXACCY39pO71dXQjJfo0hRJcYfNzFq?=
 =?iso-8859-1?Q?bTZlgt0dZxiMsLEJzsXYbFqlHiT+jsw+s4O1LJXg6m0k0F8WGtgq+m4AnN?=
 =?iso-8859-1?Q?4nfL0BJc2UrbDydwUrkpYxD7ZJR/zvCKbH2XYrmSpvgzH/EE6/zNE+tims?=
 =?iso-8859-1?Q?qdtekBXw9cZp2A0WxQm/oX6n9JUr6JasmQ2SNszikU5cFDx4KLCS/C465J?=
 =?iso-8859-1?Q?k10bzQqf1OEWgnmHXggUMXMAVI9i+K1lpJHlUuKHTodGm6NMHxKinGzGDr?=
 =?iso-8859-1?Q?DFQv7bfmkXgHxAGYBQRXp/B5SD0wsJJcYfTCgyNMhX5fPStWtdxJl4pR7Y?=
 =?iso-8859-1?Q?U0c3eHPpt0qohGEQ1nOPVyi8zMToV/Xg+ZPXshCNJeAPzc7nWz8oMVDY4K?=
 =?iso-8859-1?Q?QXUeInE7FVHueR3A60381M2jG/xQ4wu2urm7Smj42KkoPYe1RUWv7MOvMn?=
 =?iso-8859-1?Q?7bp1Ms64vna09Pop80V2keUwc/RLN9TSWD3kzSkqcJx3Iz7Si+mIUq11M0?=
 =?iso-8859-1?Q?J1/5wZKrrJtVtB+pRBo7eUmJEugYUPUNZn7GdPu6Fv0/x6BzdVLCc79qec?=
 =?iso-8859-1?Q?YFdu6mA+Q14j106Oh1OHR4thXyiukobsQ/+RkEsMSH8+jhZEoNVJ0/6+lE?=
 =?iso-8859-1?Q?iCO1ZNVjGgiGvF9UPaJBE9YxsvKiCcp5ykZp2ycIRbr61gBo1rGGp4ek9E?=
 =?iso-8859-1?Q?xZmqLanC8wGJ1S1jmfaNaYDtf4RmqR/HTgnzgrPrIoJOuTbKP8OTL4CllF?=
 =?iso-8859-1?Q?fQvaGxgYYBnJklOylh6KoUe6gnG1VEd0XT+6vsSciYU+Kv8O/tbIkn6ifz?=
 =?iso-8859-1?Q?pWdb8zfMGAQZ08/i73usGVahF3d9YsDcsX3mtXdDJfuUlKA8rP4poW//cx?=
 =?iso-8859-1?Q?KV7adlEbWSovrUBySANKoOfV5qyx9nH3anwPVO4YK5qDtCtj8kekcU0qe8?=
 =?iso-8859-1?Q?/XCJGOspbtvPwRzcf8MPd0i5W5TOHQ8BHksNkqdCp/VY15iEAhJEQKylcy?=
 =?iso-8859-1?Q?Vpcp9il0k3+2+HX60z6w1Y63iJtSOO+zqSk+cdH/YcGeYwViSB+jddqpYW?=
 =?iso-8859-1?Q?ttq2b/uH/vyTojSSQugtUUO/3x0Y9UVrDaE7m3RU8ZizkyWXVjl+EMVNrG?=
 =?iso-8859-1?Q?kCQqProdYJxmiQ1wNSK1Y8BkVYbBZViGPtoZNy7LOILWo6AN991xNCITeU?=
 =?iso-8859-1?Q?4MgkT/k4AfdF7HrFPdtIJayGBvi/G72ztkh96CQo4x6SpG4gsVJKWEredX?=
 =?iso-8859-1?Q?S5ef4sAzVjk7AmUkP3KKRwp4JgMdhYdeUQLeRjNwTl0pilzLiCo0v+Pyqj?=
 =?iso-8859-1?Q?bFmcA0ehElDJ24s3nT9iT2cTF6Q7U2h+XSKLz45EptQRIGc+k18UdYR94w?=
 =?iso-8859-1?Q?fAzpgFImO6++FGwY1owqrlcNlXdI1R0pgonA9pSpSZSYSZm7euYDOMRtgJ?=
 =?iso-8859-1?Q?synYLnwXBsHpwrMOFYq2y/xEvGyk5sl0Yl2vtjl3UN1/+SzucEWD79DQWC?=
 =?iso-8859-1?Q?HYKV3smTncR4gCx0Jo7GWNbXqG/wtfcrDL0qAh4li+e7HZTUBCRVKf1vTF?=
 =?iso-8859-1?Q?eUN1SIDjYycylBDVrJhe3kHGtT6QdxlyxR3+5KwFgOQ844QmcQn1WJAiRY?=
 =?iso-8859-1?Q?yme/N6nNqPR7AjqPH+c0E/bVNwEFs9O4KPI6GklXqEFOC9ZK8uwh73ax+N?=
 =?iso-8859-1?Q?fNg86Jk0CfxrcFkBwD2hYk+91StrEKKqKTkPh5rxifI2/emlTwrDhL8o72?=
 =?iso-8859-1?Q?JCZQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB6026.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5239dd27-a5df-4a8d-fda6-08d9e03fb0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 20:17:20.2403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPFAlRxMjgxXWSb1HxflvxoEQINSwr3iJm7QJETYsdIhqoPJHhm5gLrjPJ8oMgX8xquAqBn17hNQt4QHYbP5yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR06MB8171
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,=0A=
=0A=
=0A=
> From: Linus Torvalds <torvalds@linux-foundation.org>=0A=
> Sent: Tuesday, January 25, 2022 1:23 PM=0A=
> To: Schumaker, Anna <Anna.Schumaker@netapp.com>=0A=
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>=0A=
> Subject: Re: [GIT PULL] Please pull NFS Client Updates for 5.17 =0A=
> =A0=0A=
> NetApp Security WARNING: This is an external email. Do not click links or=
 open attachments unless you recognize the sender and know the content is s=
afe.=0A=
> =0A=
> =0A=
> =0A=
> =0A=
> On Tue, Jan 25, 2022 at 8:01 PM Anna Schumaker=0A=
> <anna.schumaker@netapp.com> wrote:=0A=
> >=0A=
> > I'm still not seeing this in your tree. Was there something wrong with=
=0A=
> > the pull request? What can I do to fix it?=0A=
> =0A=
> Hmm. It looks like these were all caught in the gmail spam filter, and=0A=
> while I go look at my spam folder regularly, I don't exactly go=0A=
> through it with a fine comb. If nothing stands out to me, it all goes=0A=
> into the great big bit-bucket in the sky.=0A=
> =0A=
> And the reason gmail considers it spam seems to be that your email is=0A=
> misconfigured. You have a "from:" field using netapp.com, but you=0A=
> don't seem to use the proper netapp smtp server, so you don't get the=0A=
> netapp DKIM signature, resulting in=0A=
> =0A=
> =A0=A0=A0=A0=A0=A0 dmarc=3Dfail (p=3DQUARANTINE sp=3DQUARANTINE dis=3DQUA=
RANTINE)=0A=
> header.from=3Dnetapp.com=0A=
> =0A=
> and that's quite the spam-trigger.=0A=
> =0A=
> In fact, from the headers it looks like you're using gmail to deliver=0A=
> the email using your schumakeranna@gmail.com gmail account, but then=0A=
> you have that "From:"=A0 having that "netapp.com" from address. Naughty,=
=0A=
> naughty.=0A=
> =0A=
> Even if gmail receives it, gmail will then notice that the from=0A=
> address has been faked, and will not deliver it to me.=0A=
> =0A=
> That whole "send email using another delivery thing than the one you=0A=
> claim it is from" is how most spam is sent, and it used to work. It=0A=
> doesn't work any more in a world where people actually check DKIM=0A=
> information, and netapp.com does have DKIM enabled.=0A=
=0A=
I hadn't heard of DKIM before, so thanks for educating me! I've deleted my =
netapp email from my gmail's "send email as" list so I won't make this mist=
ake again in the future and I'll just send from my gmail directly. I hoped =
it would would be as easy way to make it look as if it came from my work em=
ail without needing to deal with the web version of outlook (which I don't =
trust at all to send email properly).=0A=
=0A=
Thank you so much for still pulling it!=0A=
Anna=0A=
=0A=
> =0A=
> So you have to use the real netapp SMPT server if you send emails that=0A=
> claim to come from netapp.=0A=
> =0A=
> You could just use your actual normal gmail.com address - that works=0A=
> fine, and I'll see the signed tag, and the kernel.org address, and=0A=
> I'll trust it that way.=0A=
> =0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Linus=
