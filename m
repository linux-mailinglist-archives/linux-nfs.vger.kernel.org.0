Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB28B38CF18
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhEUUct (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 16:32:49 -0400
Received: from mail-dm6nam08on2069.outbound.protection.outlook.com ([40.107.102.69]:11500
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229451AbhEUUct (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 16:32:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMZxnfpYxn61xv7rV1zBM21AxrTwi5j8amQnQBQ+kuORYYFnZIsI5OSF6NQS+7gqbL2uCzDFHLqB5K5Xi+LRbfTfmShnoycnE0yR79UdBj/Pm2mkSMiLDXf2sxReXOra+uA3AKr617X+mEmJNwapIgLU9MW8AAYDeR/E/YbXsHBFJDrXTYrCmi/etJuWuodH+hdut9x91pIeKgMOvpkpa076bl2WKmr7FaAbYxxcooKOGmCWst1TD5HETrruapiomSf+Q8mddTFKvEfXrg28sql6aenNjdKPLbFHwsGSXh9TOTvfa8PyCG6lpmtDgsCjIVIBXGXtbJdAKrgDp6f1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSe59L4D/Z3sCQAtfBQ0FZCrwiA23w2aB8QOEw4Q+H4=;
 b=ETnaU2Vr7Rj/51G0byLj49DaYg5ITYBuor3izE7gmrU8uy66Y+0JEmHIalmH+oGFsRUHomdVe6mbfXaMNlWYNdapiPulrEDFSWuTXFo0/ibjhGxhddINi2uJbDaDMBjmp5i1CXY0sPh/bq04SKEoY8h5Xv2opi80td9m4tC86u/NA5cT+/l6JNLXIu4ZUMLMGL35VWpTallhBWd1+1HmKjcLw3jk74FrDJuDqX/LWYOEis+1fj64FHnF7EK3QacrWsHap9BYOOdg90F42D29XP2Hrgr+eTwRL0Z30YkgoZzusvGxf2snr6Sl9sSyKbTwYNrNFfstrLpQqa2Vow0FMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSe59L4D/Z3sCQAtfBQ0FZCrwiA23w2aB8QOEw4Q+H4=;
 b=ynYQrLEY8jJ0U5DlDi5c0s4jT+0qSbrvB0hJYdVz3aExniaY6eGinWAA1I9oCmDofuZUdfE6s7fTTj+Vt/zsFzplFbHyiyTAlb/ft2qN47MywX+gmRlR2Ul3JDPdHaVdEQWUuUE+TilqGjICIL2Z46Cb3QAscyE0505tnmKuUOY=
Received: from CO1PR05MB8101.namprd05.prod.outlook.com (2603:10b6:303:fa::14)
 by MW4PR05MB8524.namprd05.prod.outlook.com (2603:10b6:303:123::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11; Fri, 21 May
 2021 20:31:24 +0000
Received: from CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002]) by CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002%7]) with mapi id 15.20.4173.012; Fri, 21 May 2021
 20:31:23 +0000
From:   Michael Wakabayashi <mwakabayashi@vmware.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Steve Dickson <SteveD@RedHat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgAGJKICAAZPoloAADT6AgAAH7wo=
Date:   Fri, 21 May 2021 20:31:23 +0000
Message-ID: <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
 <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>,<CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
In-Reply-To: <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [67.161.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e37af771-8202-4367-24a5-08d91c9766ab
x-ms-traffictypediagnostic: MW4PR05MB8524:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR05MB8524F184EABA637DE74C8D44B7299@MW4PR05MB8524.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBwp/W07b2G/OqPwRceSwP7CzYz6wzSXlxoDWWBzVksfrb+iu74cYOppU0L6xW7gtOGXrPgCnhVmNpP8rpUcXMXMU+6KY4l9q8LLRXqu3DzfwUrCmJKlB2j+0t4jNKkZjMJxD8CPvUKY8yicI/GPwW4pz135sNn01fo0prINitJBAVLbK6Vre44FsPYyL8oNAYXG8ZqIztKnG8nphr20wvFShm6bL785DpCi589heM3GCa1ADdtQ9zMLugX+20WbF77hJfShlXTwcr9lK8B3YWeKitUegdTp4Zi5cA7nDVHcwmBMvJXOrr8oPKCaNGTeY0oxO794h44Gty9mudeoCw0JxzDQsSgn6Avj4DykM39grZtfeaxu9mTyy64EH5NvvwISAwKtxJQA0nPVGqrLSRe5WAYpm63XkX0eZSnZ5OhZbOlZP3sib/erRiC1vStBztlj2oxGWMNFvxEUftIP2VIan48gN5TMHoxDyTuu7KeLHNaZnDoUmec+0FCdL/2cFxUaR5986KckOtYwy8kxoPwyBZmmyJm46uJtU7PTdwIhdzOfUczjMXvIZPZDhcHg37EYO0zy6y1/jyO1RDhTSBDuCl6UU3LslNoER4SbTeZdYWSqH3rb23ZDLKIh2XFNQ7PKeRa3ec9TjtRi2fg/s5rSCQ4IxCXHhneQ642D0TheYVqB+SovirvH7FshKj2siXILFzL4HW7i5ZK6O578LnHHfrN+gxh73rwZVc4JmGw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8101.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(45080400002)(33656002)(316002)(7696005)(53546011)(38100700002)(2906002)(54906003)(83380400001)(6506007)(86362001)(122000001)(6916009)(55016002)(9686003)(26005)(76116006)(71200400001)(966005)(186003)(4326008)(66556008)(5660300002)(66476007)(64756008)(66446008)(66946007)(52536014)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?5MVz66v1Cr64MYaEijbfLa1NuO5VUcP8ZIcTdwEK61IrSFkSXV+5M8Eb?=
 =?Windows-1252?Q?EfYxt30OL225zMEZxZD2D7SRzemtieAjxo2N9N5DbFeolWP7fd6bddyJ?=
 =?Windows-1252?Q?6xWXvEGtOsVYX+tERg8d3flqVDpH5VHRDZf5B3NQdG1AaieSaxd3Zf7a?=
 =?Windows-1252?Q?PhdFTLmUKe1nLO4cjRelIyh1OHKKDrsHSX8wt8bvB80krDE6xX3rdUvQ?=
 =?Windows-1252?Q?3tGd8Y6otziFxSaEr0WhJiyE8Q2/hgOeQ7UvaauYUuQsECQ/PcTFqAyg?=
 =?Windows-1252?Q?cScLi/G4IPiCM2sVzsBrS2qS8s+GYdVN5W25kG3IVIRqns4eF0c+wTgC?=
 =?Windows-1252?Q?IumaztHNEA3s6ExDi/12tQDVTBQGgs9L04zS/aA7r5sg1OMM+b8tDgRB?=
 =?Windows-1252?Q?bwAb/+7blTBXFzUomTGhXYvak1JWyBpDWIiZpf+0djwAnTJMpyaXmSza?=
 =?Windows-1252?Q?VWBQnclffgd6WmD1Hy/o+0KS5YuIj/URwYZ86sT3h99l80v0cDaaUW8D?=
 =?Windows-1252?Q?iM9oEb74fXv5hUQN/1vPyJ8Zj6TbDBV8yEW1E5P+GQBftSg/3TAxejHt?=
 =?Windows-1252?Q?YkN5s4gHD/1vFi63uuuI+I80ZtDT+gwMf42VO9jkcfq3RgRtHkDujiRA?=
 =?Windows-1252?Q?NZ7g5PL3993GVtaxbDMGwlG8vKaHKsfOIL1/P70/FjYbOLC3VRqRdOkR?=
 =?Windows-1252?Q?OzuxghxchZ9B/oN9SylBfkp9pdu0BWc6XBKvSsA5RYZBaBuuJ79fRrvZ?=
 =?Windows-1252?Q?J5YrmGkVQchc5NlVb/LggUsvZTEBix4vlFMGnamHs3KVEGxD6Q+OctdO?=
 =?Windows-1252?Q?G7gtDB7iFJU8fNHthic8jfhtAYDMEy8zPlS+JUAqpQNCUKojOe8fUQMC?=
 =?Windows-1252?Q?MnQYpqxF3fA8Xx5Y5n1pdqFMyYjrlj8LBZVrIF5CLqVkww6HT+cJM12R?=
 =?Windows-1252?Q?phKizyHYjzJ21q1A2kQSL1FCOvXIy3ry0WKHeElWCQ30ESqUzf4SjBB3?=
 =?Windows-1252?Q?SA1sIHtAJtOSjMG6cIEpSjYfvDekBI61PaxRl9Q+evIuNyqVvNMU+bbT?=
 =?Windows-1252?Q?LXq9lRkItYCeOklnGq9RcHVncGJsFsSFS7Bti5yTMpbEE88HForoL86p?=
 =?Windows-1252?Q?KfBaDuHKxzSPN8KGh21Y4oPgCLuG11e/MO014Jeaj/MjnWjlMgj3jFPv?=
 =?Windows-1252?Q?+HJ7ylvvjlw5wRiGvlnUH7p6oHqfGRt2yfBSV03WjBXETVy8H7673i73?=
 =?Windows-1252?Q?Mm9T4UfvlC/qmPfH4SaEUAGEA0iWRDrdi2NBERo5113YUNiscyoJfwgH?=
 =?Windows-1252?Q?O4vRoFoWxVJdUhlPzQwVDy1ywatqfglY1GSBdjHj29BkEvPg9/EXhWRu?=
 =?Windows-1252?Q?KMJwmaW5FAJ/NVk7o0EnDzEnZ6jqPnImG0g=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37af771-8202-4367-24a5-08d91c9766ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 20:31:23.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HciCXaPOexpchbNEk0vhrJQAlgyG5Xstj/y7JrquK2n+udYm9wT6LUqBjjh+E7I6CWgSmJMtqQc47fRoAXbkXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8524
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,=0A=
=0A=
> But I would like to know  what's a legitimate reason for a machine to=0A=
> have a listening but not responsive port 2049=0A=
=0A=
The NFS server in this case was decommissioned and taken offline.=0A=
The user's automated tests was not updated and still trying to=0A=
mount this offline NFS server.=0A=
=0A=
We refer to this decommissioned server as being unreachable.=0A=
Maybe it's a difference in terminology, but for us if the IP address does n=
ot=0A=
respond to ping (as in this case), we refer to it as being  unreachable.=0A=
Other tools use this same terminology. For example "fping":=0A=
$ fping 2.2.2.2=0A=
2.2.2.2 is unreachable=0A=
=0A=
We can't really prevent users from making mistakes.=0A=
* Users will continue to accidentally mount decommissioned servers.=0A=
* Users will continue to mount the wrong IP addresses in their tests and el=
sewhere.=0A=
And when these situation occur, it will block valid NFS mounts.=0A=
=0A=
Should I be prevented from mounting NFS shares because=0A=
someone else mistyped the NFS server name in their mount command?=0A=
=0A=
From a user perspective, it's not clear why a mount of a=0A=
decommissioned(and therefore down) NFS server is blocking=0A=
mounts of every other valid NFS server?=0A=
Shouldn't these valid NFS servers be allowed to mount?=0A=
=0A=
Thanks, Mike=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
From: Olga Kornievskaia <aglo@umich.edu>=0A=
Sent: Friday, May 21, 2021 12:35 PM=0A=
To: Michael Wakabayashi <mwakabayashi@vmware.com>=0A=
Cc: Steve Dickson <SteveD@redhat.com>; linux-nfs@vger.kernel.org <linux-nfs=
@vger.kernel.org>=0A=
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS=
 mounts on same machine =0A=
=A0=0A=
On Fri, May 21, 2021 at 3:09 PM Michael Wakabayashi=0A=
<mwakabayashi@vmware.com> wrote:=0A=
>=0A=
> > This code came in with commit c156618e15101 which fixed a deadlock in n=
fs client initialization.=0A=
>=0A=
> > My conclusion is: an unresponsive server will block other mounts but on=
ly until timeout is reached.=0A=
>=0A=
> Hi Steve and Olga,=0A=
>=0A=
> We run multiple Kubernetes clusters.=0A=
> These clusters are composed of hundreds of Kubernetes nodes.=0A=
> Any of these nodes can NFS mount on behalf of the containers running on t=
hese nodes.=0A=
> We've seen several times in the past few months an NFS mount hang, and th=
en several hundred up to several thousand NFS mounts blocked by this hung N=
FS mount processes (we have many "testing" workloads that access NFS).=0A=
> Having several hundred NFS mounts blocked on a node causes the Kubernetes=
 node to become unstable and severely degrades service.=0A=
>=0A=
> We did not expect a hung NFS mount to block every other NFS mount, especi=
ally when the other mounts are unrelated and otherwise working properly.=0A=
>=0A=
> Can this behavior be changed?=0A=
=0A=
Hi Michael,=0A=
=0A=
I'm not sure if the design can be changed. But I would like to know=0A=
what's a legitimate reason for a machine to have a listening but not=0A=
responsive port 2049 (I'm sorry I don't particularly care for the=0A=
explanation of "because this is how things currently work in=0A=
containers, Kubernetes"). Seems like the problem should be fixed=0A=
there. There is no issue if a mount goes to an IP that has nothing=0A=
listening on port 2049.=0A=
=0A=
Again I have no comments on the design change: or rather my comment=0A=
was I don't see a way. If you have 2 parallel clients initializing and=0A=
the goal is to have at most one client if both are the same, then I=0A=
don't see a way besides serializing it as it's done now.=0A=
=0A=
>=0A=
> Thanks, Mike=0A=
>=0A=
>=0A=
> ________________________________=0A=
> From: Steve Dickson <SteveD@RedHat.com>=0A=
> Sent: Thursday, May 20, 2021 11:42 AM=0A=
> To: Olga Kornievskaia <aglo@umich.edu>; Michael Wakabayashi <mwakabayashi=
@vmware.com>=0A=
> Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
> Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other N=
FS mounts on same machine=0A=
>=0A=
> Hey.=0A=
>=0A=
> On 5/19/21 3:15 PM, Olga Kornievskaia wrote:=0A=
> > On Sun, May 16, 2021 at 11:18 PM Michael Wakabayashi=0A=
> > <mwakabayashi@vmware.com> wrote:=0A=
> >>=0A=
> >> Hi,=0A=
> >>=0A=
> >> We're seeing what looks like an NFSv4 issue.=0A=
> >>=0A=
> >> Mounting an NFS server that is down (ping to this NFS server's IP addr=
ess does not respond) will block _all_ other NFS mount attempts even if the=
 NFS servers are available and working properly (these subsequent mounts ha=
ng).=0A=
> >>=0A=
> >> If I kill the NFS mount process that's trying to mount the dead NFS se=
rver, the NFS mounts that were blocked will immediately unblock and mount s=
uccessfully, which suggests the first mount command is blocking the other m=
ount commands.=0A=
> >>=0A=
> >>=0A=
> >> I verified this behavior using a newly built mount.nfs command from th=
e recent nfs-utils 2.5.3 package installed on a recent version of Ubuntu Cl=
oud Image 21.04:=0A=
> >> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
sourceforge.net%2Fprojects%2Fnfs%2Ffiles%2Fnfs-utils%2F2.5.3%2F&amp;data=3D=
04%7C01%7Cmwakabayashi%40vmware.com%7C254806799e3f45388def08d91c8f9c45%7Cb3=
9138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637572225410414697%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C1000&amp;sdata=3DqWsYLeSLC0k89%2FHJGqhMlBnEvGR%2Bdqxve4n56bww%2Bnk%3D&am=
p;reserved=3D0=0A=
> >> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
cloud-images.ubuntu.com%2Freleases%2Fhirsute%2Frelease-20210513%2Fubuntu-21=
.04-server-cloudimg-amd64.ova&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.co=
m%7C254806799e3f45388def08d91c8f9c45%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0=
%7C0%7C637572225410414697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI=
joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5sHt34ZBtsa7Mj=
RP0RbymhbjOn%2FT5X5JUWvIQV93PUU%3D&amp;reserved=3D0=0A=
> >>=0A=
> >>=0A=
> >> The reason this looks like it is specific to NFSv4 is from the followi=
ng output showing "vers=3D4.2":=0A=
> >>> $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt=0A=
> >>> [ ... cut ... ]=0A=
> >>> mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "vers=
=3D4.2,addr=3D<unreachable-IP-address>,clien"...^C^Z=0A=
> >>=0A=
> >> Also, if I try the same mount.nfs commands but specifying NFSv3, the m=
ount to the dead NFS server hangs, but the mounts to the operational NFS se=
rvers do not block and mount successfully; this bug doesn't happen when usi=
ng NFSv3.=0A=
> >>=0A=
> >>=0A=
> >> We reported this issue under util-linux here:=0A=
> >> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
thub.com%2Fkarelzak%2Futil-linux%2Fissues%2F1309&amp;data=3D04%7C01%7Cmwaka=
bayashi%40vmware.com%7C254806799e3f45388def08d91c8f9c45%7Cb39138ca3cee4b4aa=
4d6cd83d9dd62f0%7C0%7C0%7C637572225410414697%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda=
ta=3DUrD%2FaBX2S4Qq7CrgltIc9lEzA8oEQQn0srMXtrq%2B6CE%3D&amp;reserved=3D0=0A=
> >> [mounting nfs server which is down blocks all other nfs mounts on same=
 machine #1309]=0A=
> >>=0A=
> >> I also found an older bug on this mailing list that had similar sympto=
ms (but could not tell if it was the same problem or not):=0A=
> >> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
tchwork.kernel.org%2Fproject%2Flinux-nfs%2Fpatch%2F87vaori26c.fsf%40notaben=
e.neil.brown.name%2F&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7C25480=
6799e3f45388def08d91c8f9c45%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C63=
7572225410414697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DlBAE9wZbykGQ8VPH6YsAtua=
IpMpDcAtqsxVNDV%2BaNTk%3D&amp;reserved=3D0=0A=
> >> [[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]=0A=
> >>=0A=
> >> Thanks, Mike=0A=
> >=0A=
> > Hi Mike,=0A=
> >=0A=
> > This is not a helpful reply but I was curious if I could reproduce=0A=
> > your issue but was not successful. I'm able to initiate a mount to an=
=0A=
> > unreachable-IP-address which hangs and then do another mount to an=0A=
> > existing server without issues. Ubuntu 21.04 seems to be 5.11 based so=
=0A=
> > I tried upstream 5.11 and I tried the latest upstream nfs-utils=0A=
> > (instead of what my distro has which was an older version).=0A=
> >=0A=
> > To debug, perhaps get an output of the nfs4 and sunrpc tracepoints.=0A=
> > Or also get output from dmesg after doing =93echo t >=0A=
> > /proc/sysrq-trigger=94 to see where the mounts are hanging.=0A=
> >=0A=
> It looks like Mike is correct... The first process (mount 1.1.1.1:/mnt) i=
s=0A=
> hung in trying the connection:=0A=
>=0A=
> PID: 3394=A0=A0 TASK: ffff9da8c42734c0=A0 CPU: 0=A0=A0 COMMAND: "mount.nf=
s"=0A=
>=A0 #0 [ffffb44780f638c8] __schedule at ffffffff82d7959d=0A=
>=A0 #1 [ffffb44780f63950] schedule at ffffffff82d79f2b=0A=
>=A0 #2 [ffffb44780f63968] rpc_wait_bit_killable at ffffffffc05265ce [sunrp=
c]=0A=
>=A0 #3 [ffffb44780f63980] __wait_on_bit at ffffffff82d7a4ba=0A=
>=A0 #4 [ffffb44780f639b8] out_of_line_wait_on_bit at ffffffff82d7a5a6=0A=
>=A0 #5 [ffffb44780f63a00] __rpc_execute at ffffffffc052fc8a [sunrpc]=0A=
>=A0 #6 [ffffb44780f63a48] rpc_execute at ffffffffc05305a2 [sunrpc]=0A=
>=A0 #7 [ffffb44780f63a68] rpc_run_task at ffffffffc05164e4 [sunrpc]=0A=
>=A0 #8 [ffffb44780f63aa8] rpc_call_sync at ffffffffc0516573 [sunrpc]=0A=
>=A0 #9 [ffffb44780f63b00] rpc_create_xprt at ffffffffc051672e [sunrpc]=0A=
> #10 [ffffb44780f63b40] rpc_create at ffffffffc0516881 [sunrpc]=0A=
> #11 [ffffb44780f63be8] nfs_create_rpc_client at ffffffffc0972319 [nfs]=0A=
> #12 [ffffb44780f63c80] nfs4_init_client at ffffffffc0a17882 [nfsv4]=0A=
> #13 [ffffb44780f63d70] nfs4_set_client at ffffffffc0a16ef8 [nfsv4]=0A=
> #14 [ffffb44780f63de8] nfs4_create_server at ffffffffc0a188d8 [nfsv4]=0A=
> #15 [ffffb44780f63e60] nfs4_try_get_tree at ffffffffc0a0bf69 [nfsv4]=0A=
> #16 [ffffb44780f63e80] vfs_get_tree at ffffffff823b6068=0A=
> #17 [ffffb44780f63ea0] path_mount at ffffffff823e3d8f=0A=
> #18 [ffffb44780f63ef8] __x64_sys_mount at ffffffff823e45a3=0A=
> #19 [ffffb44780f63f38] do_syscall_64 at ffffffff82d6aa50=0A=
> #20 [ffffb44780f63f50] entry_SYSCALL_64_after_hwframe at ffffffff82e0007c=
=0A=
>=0A=
> The second mount is hung up in nfs_match_client()/nfs_wait_client_init_co=
mplete=0A=
> waiting for the first process to compile=0A=
> nfs_match_client:=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* If a client is still initializing then we need to=
 wait */=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 if (clp->cl_cons_state > NFS_CS_READY) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 refcount_inc(&clp->cl_count);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_unlock(&nn->nfs_client_lock);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error =3D nfs_wait_client_init_comple=
te(clp);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nfs_put_client(clp);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_lock(&nn->nfs_client_lock);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (error < 0)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ERR_PTR(error);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto again;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=0A=
> This code came in with commit c156618e15101 which fixed=0A=
> a deadlock in nfs client initialization.=0A=
>=0A=
> steved.=0A=
>=
